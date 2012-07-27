package com.dborisenko.api.twitter.net
{
	import com.dborisenko.api.twitter.TwitterAPI;
	import com.dborisenko.api.twitter.commands.streaming.StreamingParser;
	import com.dborisenko.api.twitter.data.StreamingObject;
	import com.dborisenko.api.twitter.events.TwitterStreamingEvent;
	import com.dborisenko.api.twitter.interfaces.ITwitterOperation;
	import com.dborisenko.api.twitter.twitter_internal;
	
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLStream;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	
	
	/**
	 *  The Streaming APIs are a way to make a continous connection to Twitter. the benefit of using them is that you do not hvae to make individual
	 *  requests for data constantly to keep things updated, the stream will notify you of things as they happen.
	 * 
	 *  The various streaming components are described here: https://dev.twitter.com/docs/streaming-apis
	 * 
	 *  The parameter types for streaming operations are described here: https://dev.twitter.com/docs/streaming-apis/parameters
	 **/
	
	public class TwitterStreamingOperation extends EventDispatcher implements ITwitterOperation
	{
		public static const METHOD_GET			:String 	= "GET";
		public static const METHOD_POST			:String		= "POST";
		
		
		protected var urlStream:URLStream; // for grabbing the data.
		protected var urlRequest:URLRequest;
		protected var jsonBuffer:String = "";
		
		public var url:String;
		public var params:URLVariables;
		public var method:String;
		public var headers:Array = [];
		
		/**
		 * Twitter API instance.
		 */
		protected var twitterAPI:TwitterAPI;
		
		/**
		 * @private
		 */		
		protected var _requiresAuthentication:Boolean = true;
		
		/**
		 * @private
		 */	
		protected var _apiRateLimited:Boolean = true;
		
		
		[Event(name="progress",type="com.dborisenko.api.twitter.events.TwitterStreamingEvent")]
		[Event(name="streamError",type="com.dborisenko.api.twitter.events.TwitterStreamingEvent")]
		
		public function TwitterStreamingOperation(url:String, requiresAuthentication:Boolean = true, params:Object=null)
		{
			this.parameters = params;
			this.url = url;
			this._requiresAuthentication = requiresAuthentication;
		}
		
		public function get requiresAuthentication():Boolean
		{
			return _requiresAuthentication;
		}
		
		public function get apiRateLimited():Boolean
		{
			return _apiRateLimited;
		}
		
		public function execute():void
		{
			initOperation(); //generates the headers and parameters.
			urlStream = new URLStream();
			urlRequest = new URLRequest(url);
			urlRequest.method = method;
			urlRequest.requestHeaders = headers;
			urlRequest.data = parameters;
			urlStream.addEventListener(ProgressEvent.PROGRESS, onStreamProgress);
			urlStream.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, onHTTPResponseStatus);
			urlStream.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatus);
			urlStream.addEventListener(IOErrorEvent.IO_ERROR, onStreamError);
			
			trace("Creating Streaming Request");
			
			try{
				urlStream.load(urlRequest);
			}catch (e:Error){
				trace("Twitter Streaming: Bad URL");
			}
		}
		
		public function setTwitterAPI(api:TwitterAPI):void
		{
			twitterAPI = api;
		}
		
		
		public function closeStream():void
		{
			if(urlStream.connected)
				urlStream.close();
		}
		
		/**
		 * Event handling
		 **/
		
		private function onStreamProgress(event:ProgressEvent):void
		{
			trace("Twitter Streaming Progress");
			var bytes:ByteArray = new ByteArray(); // to store the incoming bytes.
			urlStream.readBytes(bytes, 0, urlStream.bytesAvailable); //reads all of the incoming bytes into the array
			var incomingText:String = bytes.toString();
			trace("Text Received: " + incomingText);
			parseFeedJSON(incomingText);
		}
		
		private function onHTTPResponseStatus(event:HTTPStatusEvent):void
		{
			if(event.status > 200){
				//something went WRONG.
				urlStream.close();
				dispatchEvent(new TwitterStreamingEvent(TwitterStreamingEvent.STREAM_ERROR, null, false, event));
			}
			
			trace("Twitter Streaming On HTTP Response Status: " + event.status);
		}
		
		private function onHTTPStatus(event:HTTPStatusEvent):void
		{
			trace("Twitter Streaming On HTTP Status: " + event.status);
		}
		
		private function onStreamError(event:IOErrorEvent):void
		{
			urlStream.close();
			trace("Twitter Streaming IO Error: " + event.toString()); 
			dispatchEvent(new TwitterStreamingEvent(TwitterStreamingEvent.STREAM_ERROR, null, false, event));
		}
		
		
		
		/**
		 * Parsing the incoming JSON is tricky. Have to save unfinished previous data and then add the incoming data to it
		 * and then parse it to see if you have a completed tweet. Once we have some completed JSON, we have to decide what
		 * it is -- A Tweet, an Error Message, a Friends List, etc. so we can parse it properly. Finally, we notify the
		 * listeners that we have new data.
		 * 
		 * Parsing idea from: http://blog.nictunney.com/2011/09/accessing-twitter-streaming-api-from.html
		 * 
		 * @param newText         required. The JSON to add to the buffer for parsing.
		 **/
		protected function parseFeedJSON(newText:String):void
		{
			//add the new text
			jsonBuffer += newText;
			
			var jsonParts:Array = jsonBuffer.split(/\r\n/); //Newline ends an object. Examples are showing \n, docs hint to use \r\n. Hrm.
			//if we have something, loop over what we have.
			if(newText != "\r\n"){
				jsonBuffer = ""; // clear buffer, we've read it into this chunk.
				var parser:StreamingParser = new StreamingParser();
				for each(var json:String in jsonParts){
					if(json.length != 0){
						try{
							//docs are totally worthless here. I assume it'll throw an error if the data isn't valid JSON. ie. incomplete.
							var newData:Object = JSON.parse(json);
							//DO PARSING.
							var output:StreamingObject = parser.parseData(newData);
							//notify we have progress.
							dispatchEvent(new TwitterStreamingEvent(TwitterStreamingEvent.PROGRESS, output, true, newText));
						} catch(e:Error){
							jsonBuffer += json; // didn't parse, add this text back.
						}
					}
				}
			}else{
				dispatchEvent(new TwitterStreamingEvent(TwitterStreamingEvent.PROGRESS, new StreamingObject({}, StreamingObject.TYPE_EMPTY), true, newText));
			}
			trace("Twitter Streaming JSON parsed");
		}
		
		
		
		
		/**
		 * Initialize the operation.
		 * 
		 */
		protected function initOperation():void
		{
			if (requiresAuthentication && twitterAPI.connection != null)
			{
				var oauthParams:Object = params;
				var newUrl:String = url;
				
				if (params == null && newUrl.indexOf("?") != -1)
				{
					oauthParams = {};
					var arr1:Array = url.split("?");
					newUrl = arr1[0].toString();
					
					if (arr1.length > 1)
					{
						var arr2:Array = arr1[1].toString().split("&");
						
						for (var i:int = 0; i < arr2.length; i++)
						{
							var kv:Array = arr2[i].toString().split("=");
							oauthParams[kv[0].toString()] = kv[1].toString();
						}
					}
				}
				var headerParams:Object = {};
				
				for (var key:String in oauthParams)
				{
					headerParams[key] = oauthParams[key];
				}
				
				
				var header:URLRequestHeader = twitterAPI.connection.createOAuthHeader(
					method, newUrl, headerParams);
				if (header)
				{
					headers.push(header);
					//var hName:String = header.name;
					//var hValue:String = header.value;
					//headers[hName] = hValue;
				}
				
				
			}
		}
		
		/**
		 * Convert <code>params</code> to the correct parameters object.
		 * The value is ignoreg if
		 * <ul>
		 * 	<li>value is <code>String</code> and equals <code>null</code></li>
		 * 	<li>value is <code>int</code> and equals <code>-1</code>
		 * </ul>
		 */
		protected static function convertToParameters(params:Object):URLVariables
		{
			var result:URLVariables = new URLVariables();
			for (var key:String in params)
			{
				trace("Parameter: " + key + " Value: " + params[key]);
				if ( ((params[key] is String) && (params[key] != null)) ||
					((params[key] is int) && (params[key] != -1)) ||
					(params[key] is Boolean) ||
					((params[key] is Array) && ((params[key] as Array).length != 0))
					
				)
				{
					result[key] = params[key];
				}
			}
			return result;
		}
		
		/**
		 * 
		 * Parameters of the operation in correct format.
		 * 
		 */
		protected function set parameters(value:Object):void
		{
			params = convertToParameters(value);
		}
		protected function get parameters():Object
		{
			return params;
		}
		
		
		
		
	}
}
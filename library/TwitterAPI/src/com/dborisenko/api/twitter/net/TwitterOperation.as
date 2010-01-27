/** TwitterOperation.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.net
{
	import com.adobe.protocols.dict.events.ErrorEvent;
	import com.dborisenko.api.HttpOperation;
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.TwitterAPI;
	import com.dborisenko.api.twitter.data.TwitterUser;
	import com.dborisenko.api.twitter.events.TwitterEvent;
	import com.dborisenko.api.twitter.interfaces.ITwitterOperation;
	import com.dborisenko.api.twitter.twitter_internal;
	
	import flash.events.Event;
	import flash.net.URLRequestHeader;
	
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	
	use namespace twitter_internal;
	
	[Event(name="complete",type="com.dborisenko.api.twitter.events.TwitterEvent")]
	public class TwitterOperation extends HttpOperation implements ITwitterOperation
	{
		protected var twitterAPI:TwitterAPI;
		
		[Bindable]
		public var data:Object;
		
		protected var _requiresAuthentication:Boolean = true;
		protected var _apiRateLimited:Boolean = true;
		
		public function TwitterOperation(url:String, requiresAuthentication:Boolean = true, params:Object=null, 
										 resultFormat:String=ResultFormat.XML)
		{
			super(url, params, resultFormat);
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
		
		override public function execute() : void
		{
			initOperation();
			super.execute();
		}
		
		override public function result(data:Object) : void
		{
			dispatchEvent(new TwitterEvent(TwitterEvent.COMPLETE, data, true));
		}
		
		override public function fault(info:Object) : void
		{
			var faultString:String;
			if (info is Fault)
			{
				faultString = Fault(info).faultString;
			}
			else if (info)
			{
				faultString = info.toString();
			}
//			var fault:FaultObject = new FaultObject();
//			fault.faultString = faultString;
//			fault.sender = this;
			
			dispatchEvent(new TwitterEvent(TwitterEvent.COMPLETE, faultString, false));
		}
		
		twitter_internal function setTwitterAPI(api:TwitterAPI):void
		{
			twitterAPI = api;
		}
		
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
					var hName:String = header.name;
					var hValue:String = header.value;
					headers[hName] = hValue;
				}
			}
		}
		
		protected static function convertToParameters(params:Object):Object
		{
			var result:Object = {};
			for (var key:String in params)
			{
				if (params[key] is String && params[key] != null ||
					params[key] is int && params[key] != -1)
				{
					result[key] = params[key];
				}
			}
			return result;
		}
		
		protected function set parameters(value:Object):void
		{
			params = convertToParameters(value);
		}
		protected function get parameters():Object
		{
			return params;
		}
		
		protected static function getScreenName(recipient:Object):String
		{
			var screenName:String;
			if (recipient is TwitterUser)
				screenName = TwitterUser(recipient).screenName;
			else
				screenName = recipient.toString();
			return screenName;
		}
		
		override protected function handleResult(event:Event):void
		{
			if (resultFormat == ResultFormat.XML)
			{
				var xml:XML = getXML();
				if (xml.name() == "hash" && xml.contains("error"))
				{
					fault(xml.error);
				}
				else
				{
					result(data);
				}
			}
			else if (resultFormat == ResultFormat.JSON)
			{
				result(data);
			}
		}
		override protected function handleFault(event:Event):void
		{
			if (event is ErrorEvent)
			{
				fault(ErrorEvent(event).message);
			}
			else if (event is FaultEvent)
			{
				var details:String = "Check your Internet connection";
				
				if (FaultEvent(event).fault.content)
				{
					try
					{
						var errorXML:XML = new XML(FaultEvent(event).fault.content);
						if (errorXML.name() == "hash" && errorXML.error)
							details = errorXML.error.toString();
						if (errorXML.name() == "errors" && errorXML.error)
							details = errorXML.error.toString();
					}
					catch (error:Error)
					{
					}
				}
				fault(details);
			}
			else
			{
				fault("Check your Internet connection");
			}
		}
	}
}
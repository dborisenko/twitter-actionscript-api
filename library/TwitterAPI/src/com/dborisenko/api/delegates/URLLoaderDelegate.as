/** URLLoaderDelegate.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2010.
 */
package com.dborisenko.api.delegates
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLVariables;
	
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	[Event(name="result",type="mx.rpc.events.ResultEvent")]
	[Event(name="fault",type="mx.rpc.events.FaultEvent")]
	public class URLLoaderDelegate extends EventDispatcher implements IServiceDelegate
	{
		protected var urlLoader:URLLoader;
		protected var urlRequest:URLRequest;
		
		private var _headers:Object;
		private var _method:String;
		private var _url:String;
		private var _params:Object;
		private var _resultFormat:String;
		
		public function URLLoaderDelegate()
		{
		}
		
		public function get resultFormat():String
		{
			return _resultFormat;
		}
		public function set resultFormat(value:String):void
		{
			_resultFormat = value;
		}

		public function get params():Object
		{
			return _params;
		}
		public function set params(value:Object):void
		{
			_params = value;
		}

		public function get method():String
		{
			return _method;
		}
		public function set method(value:String):void
		{
			_method = value;
		}

		public function get headers():Object
		{
			return _headers;
		}
		public function set headers(value:Object):void
		{
			_headers = value;
		}

		public function get url():String
		{
			return _url;
		}
		public function set url(value:String):void
		{
			_url = value;
		}
		
		public function get lastResult():Object
		{
			if (urlLoader)
				return urlLoader.data;
			return null;
		}
		
		public function send():void
		{
			urlLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, handleResult);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleFault);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, handleFault);
			
			urlRequest = new URLRequest(url);
			
			if (headers)
			{
				var rHeaders:Array = new Array();
				for (var headerKey:String in headers)
				{
					rHeaders.push(new URLRequestHeader(headerKey, headers[headerKey]));
				}
				urlRequest.requestHeaders = rHeaders;
			}
			if (method)
			{
				urlRequest.method = method;
			}
			if (params)
			{
				var variables:URLVariables = new URLVariables();
				for (var variableKey:String in params)
				{
					variables[variableKey] = params[variableKey];
				}
				urlRequest.data = variables;
			}
//			urlRequest.authenticate = false;
			
			urlLoader.load(urlRequest);
		}
		
		protected function handleResult(event:Event):void
		{
			dispatchEvent(new ResultEvent(ResultEvent.RESULT, false, true, lastResult));
		}
		
		protected function handleFault(event:ErrorEvent):void
		{
			var fault:Fault = new Fault(event.errorID.toString(), event.text);
			dispatchEvent(new FaultEvent(FaultEvent.FAULT, false, true, fault));
		}
	}
}
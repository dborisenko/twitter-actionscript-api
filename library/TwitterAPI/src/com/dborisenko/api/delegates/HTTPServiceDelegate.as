/** HTTPServiceDelegate.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2010.
 */
package com.dborisenko.api.delegates
{
	import com.dborisenko.api.enums.ResultFormat;
	
	import flash.events.EventDispatcher;
	
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	[Event(name="result",type="mx.rpc.events.ResultEvent")]
	[Event(name="fault",type="mx.rpc.events.FaultEvent")]
	public class HTTPServiceDelegate extends EventDispatcher implements IServiceDelegate
	{
		protected var httpService:HTTPService;
		
		private var _headers:Object;
		private var _method:String;
		private var _url:String;
		private var _params:Object;
		private var _resultFormat:String;
		
		public function HTTPServiceDelegate()
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
			if (httpService)
				return httpService.lastResult;
			return null;
		}
		
		public function send():void
		{
			httpService = new HTTPService();
			httpService.addEventListener(ResultEvent.RESULT, handleResult);
			httpService.addEventListener(FaultEvent.FAULT, handleFault);
			
			httpService.url = url;
			
			if (headers)
			{
				for (var key:String in headers)
				{
					httpService.headers[key] = headers[key];
				}
			}
			
			if (method)
			{
				httpService.method = method;
			}
			switch (resultFormat)
			{
				case ResultFormat.JSON:
					httpService.resultFormat = HTTPService.RESULT_FORMAT_TEXT;
					break;
				case ResultFormat.XML:
				default:
					httpService.resultFormat = HTTPService.RESULT_FORMAT_E4X;
					break;
			}
			
			httpService.send(params);
		}
		
		protected function handleResult(event:ResultEvent):void
		{
			dispatchEvent(new ResultEvent(ResultEvent.RESULT, false, true, event.result));
		}
		
		protected function handleFault(event:FaultEvent):void
		{
			var fault:Fault = new Fault(event.fault.faultCode, event.fault.faultString, event.fault.faultDetail);
			dispatchEvent(new FaultEvent(FaultEvent.FAULT, false, true, fault));
		}
	}
}
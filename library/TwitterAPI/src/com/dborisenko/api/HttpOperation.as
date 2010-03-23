/** HttpOperation.as
 * 
 * @author Denis Borisenko
 * 
 * Copyright (c) 2009.
 */
package com.dborisenko.api
{
    import com.adobe.serialization.json.JSON;
    import com.dborisenko.api.delegates.HTTPServiceDelegate;
    import com.dborisenko.api.delegates.IServiceDelegate;
    import com.dborisenko.api.delegates.URLLoaderDelegate;
    import com.dborisenko.api.enums.ResultFormat;
    
    import flash.events.ErrorEvent;
    import flash.events.Event;
    import flash.net.URLLoader;
    
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    
	/**
	 * Base HTTP Operation class
	 * @author Denis Borisenko
	 * 
	 */
    public class HttpOperation extends Operation
    {
		public static const METHOD_GET			:String 	= "GET";
		public static const METHOD_POST			:String		= "POST";
		public static const METHOD_HEAD			:String 	= "HEAD";
		public static const METHOD_OPTIONS		:String 	= "OPTIONS";
		public static const METHOD_PUT			:String 	= "PUT";
		public static const METHOD_TRACE		:String 	= "TRACE";
		public static const METHOD_DELETE		:String 	= "DELETE";
		
		protected var serviceDelegate:IServiceDelegate;
		
        [Bindable]
        public var url:String;
        
        [Bindable]
        public var params:Object;
        
		[Bindable]
		public var method:String;
		
		[Bindable]
		public var headers:Object = {};
		
        [Bindable]
        public var resultFormat:String = ResultFormat.XML;
		
        public function HttpOperation(url:String, params:Object = null, resultFormat:String=ResultFormat.XML)
        {
			this.params = params;
			this.url = url;
			this.resultFormat = resultFormat;
        }
        
        override public function execute():void
        {
			if (!method || method == METHOD_GET || method == METHOD_POST)
			{
				serviceDelegate = new HTTPServiceDelegate();
			}
			else
			{
				serviceDelegate = new URLLoaderDelegate();
			}
			serviceDelegate.headers = headers;
			serviceDelegate.method = method;
			serviceDelegate.params = params;
			serviceDelegate.resultFormat = resultFormat;
			serviceDelegate.url = url;
			
			serviceDelegate.addEventListener(ResultEvent.RESULT, handleResult);
			serviceDelegate.addEventListener(FaultEvent.FAULT, handleFault);
			serviceDelegate.send();
        }
		
		protected function handleResult(event:Event):void
		{
			var res:Object;
			if (event is ResultEvent)
				res = ResultEvent(event).result;
			result(res);
		}
		
		protected function handleFault(event:Event):void
		{
			var info:Object;
			if (event is FaultEvent)
				info = FaultEvent(event).fault.faultString;
			fault(info);
		}
        
		public function getResult():Object
		{
			if (serviceDelegate)
			{
				return serviceDelegate.lastResult;
			}
			return null;
		}
		
        public function getXML():XML
        {
			if (resultFormat == ResultFormat.XML)
			{
				var res:Object = getResult();
				if (!res)
				{
					return null;
				}
				else if (res is XML)
				{
            		return res as XML;
				}
				else
				{
					return new XML(res.toString());
				}
			}
			return null;
        }
        
        public function getJSON():Object
        {
			if (resultFormat == ResultFormat.JSON)
			{
				try
				{
					return JSON.decode(getResult().toString());
				}
				catch (error:Error)
				{
				}
			}
			return null;
        }
    }
}
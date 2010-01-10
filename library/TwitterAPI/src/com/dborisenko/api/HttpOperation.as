/** HttpOperation.as
 * 
 * @author Denis Borisenko
 * 
 * Copyright (c) 2009.
 */
package com.dborisenko.api
{
    import com.adobe.serialization.json.JSON;
    
    import flash.events.Event;
    import flash.net.URLRequestMethod;
    
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.http.HTTPService;
    
    public class HttpOperation extends Operation
    {
    	public static const RESULT_FORMAT_XML	:String 	= "xml";
    	public static const RESULT_FORMAT_JSON	:String 	= "json";
    	
		public static const METHOD_GET			:String 	= "GET";
		public static const METHOD_POST			:String		= "POST";
		public static const METHOD_HEAD			:String 	= "HEAD";
		public static const METHOD_OPTIONS		:String 	= "OPTIONS";
		public static const METHOD_PUT			:String 	= "PUT";
		public static const METHOD_TRACE		:String 	= "TRACE";
		public static const METHOD_DELETE		:String 	= "DELETE";
		
        [Bindable]
        public var url:String;
        
        [Bindable]
        public var params:Object;
        
        [Bindable]
        public var service:HTTPService;
        
		[Bindable]
		public var method:String;
		
        [Bindable]
        public var resultFormat:String = RESULT_FORMAT_XML;

        public function HttpOperation(url:String, params:Object = null, resultFormat:String=RESULT_FORMAT_XML)
        {
			this.params = params;
			this.url = url;
			this.resultFormat = resultFormat;
			
            service = new HTTPService();
            service.addEventListener(ResultEvent.RESULT, handleResult);
            service.addEventListener(FaultEvent.FAULT, handleFault);
        }
        
        override public function execute():void
        {
			service.url = url;
			
			if (method)
			{
				service.method = method;
			}
            switch (resultFormat)
            {
            	case RESULT_FORMAT_JSON:
            		service.resultFormat = HTTPService.RESULT_FORMAT_TEXT;
            	break;
            	case RESULT_FORMAT_XML:
            	default:
            		service.resultFormat = HTTPService.RESULT_FORMAT_E4X;
            	break;
            }
            
            service.send(params);
        }
        
        protected function handleResult(event:Event):void
        {
			var result:Object;
			if (event is ResultEvent)
				result = ResultEvent(event).result;
            result(result);
        }
		
		protected function handleFault(event:Event):void
		{
			var info:Object;
			if (event is FaultEvent)
				info = FaultEvent(event).fault.faultString;
			fault(fault);
		}
        
		public function getResult():Object
		{
			return service.lastResult;
		}
		
        public function getXML():XML
        {
			if (resultFormat == RESULT_FORMAT_XML)
            	return getResult() as XML;
			return null;
        }
        
        public function getJSON():Object
        {
			if (resultFormat == RESULT_FORMAT_JSON)
			{
				try
				{
					return JSON.decode(getResult() as String);
				}
				catch (error:Error)
				{
				}
			}
			return null;
        }
    }
}
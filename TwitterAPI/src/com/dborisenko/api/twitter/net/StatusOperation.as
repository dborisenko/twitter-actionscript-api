/** StatusOperation.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.net
{
	import com.dborisenko.api.twitter.data.TwitterStatus;
	
	import flash.events.Event;
	
	public class StatusOperation extends TwitterOperation
	{
		public function StatusOperation(url:String, requiresAuthentication:Boolean=true, 
			params:Object=null)
		{
			super(url, requiresAuthentication, params);
		}
		
		[Bindable]
		public function get status():TwitterStatus
		{
			return data as TwitterStatus;
		}
		
		public function set status(value:TwitterStatus):void
		{
			data = value;
		}
		
		override protected function handleResult(event:Event) : void
        {
			var xml:XML = getXML();
        	if (xml.name() == "status")
        	{
	        	status = new TwitterStatus(xml);
        	}
            super.handleResult(event);
        }
	}
}
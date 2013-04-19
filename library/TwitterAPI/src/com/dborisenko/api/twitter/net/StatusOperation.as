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
	
	/**
	 * 
	 * Base operation for work with Twitter Status
	 * @author Denis Borisenko
	 * 
	 */
	public class StatusOperation extends TwitterOperation
	{
		public function StatusOperation(url:String, requiresAuthentication:Boolean=true, 
			params:Object=null)
		{
			super(url, requiresAuthentication, params);
		}
		
		/**
		 * 
		 * Twitter Status, received by the operation. 
		 * 
		 */
		[Bindable]
		public function get status():TwitterStatus
		{
			return data as TwitterStatus;
		}
		public function set status(value:TwitterStatus):void
		{
			data = value;
		}
		
		/**
		 * 
		 * @private
		 * 
		 */
		override protected function handleResult(event:Event) : void
        {
			var json:Object = getJSON();
			status = new TwitterStatus(json);
        	super.handleResult(event);
        }
	}
}
/** StatusesOperation.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.net
{
	import com.dborisenko.api.twitter.data.TwitterStatus;
	import com.dborisenko.api.twitter.data.collections.StatusesCollection;
	
	import flash.events.Event;
	
	/**
	 * 
	 * Base operation for work with Collection of Twitter Statuses
	 * @author Denis Borisenko
	 * 
	 */
	public class StatusesOperation extends TwitterOperation
	{	
		private var isMention:Boolean = false;
		
		public function StatusesOperation(url:String, requiresAuthentication:Boolean = true, 
			params:Object=null, isMentions:Boolean=false)
		{
			super(url, requiresAuthentication, params);
			this.isMention = isMentions;
		}
	
		/**
		 * 
		 * Collection of Twitter Statuses, received by the operation. 
		 * 
		 */
		[Bindable]
		public function get statuses():StatusesCollection
		{
			return data as StatusesCollection;
		}
		public function set statuses(value:StatusesCollection):void
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
			//trace(this.serviceDelegate.url);
			//trace(getResult().toString());
			var json:Array = getJSON() as Array;
        	statuses = new StatusesCollection();
	        	
            for each (var item:Object in json)
        	{
        		var status:TwitterStatus = new TwitterStatus(item);
        		status.isMention = isMention;
        		statuses.addItem(status);
        	}
    	
            super.handleResult(event);
        }
	}
}
/** DirectMessageOperation.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.net
{
	import com.dborisenko.api.twitter.data.TwitterDirectMessage;
	
	import flash.events.Event;

	/**
	 * 
	 * Base operation for work with Twitter Direct Message
	 * @author Denis Borisenko
	 * 
	 */
	public class DirectMessageOperation extends TwitterOperation
	{
		private var isSent:Boolean = true;
		
		public function DirectMessageOperation(url:String, requiresAuthentication:Boolean=true, 
			params:Object=null, isSent:Boolean=true)
		{
			super(url, requiresAuthentication, params);
			
			this.isSent = isSent;
		}
		
		/**
		 * 
		 * Twitter Direct Message, received by the operation. 
		 * 
		 */
		[Bindable]
		public function get directMessage():TwitterDirectMessage
		{
			return data as TwitterDirectMessage;
		}
		public function set directMessage(value:TwitterDirectMessage):void
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
			directMessage = new TwitterDirectMessage(json);
			directMessage.isSent = isSent;
			
            super.handleResult(event);
        }
	}
}
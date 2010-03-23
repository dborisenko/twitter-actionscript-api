/** DirectMessagesOperation.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.net
{
	import com.dborisenko.api.twitter.data.TwitterDirectMessage;
	import com.dborisenko.api.twitter.data.collections.DirectMessagesCollection;
	
	import flash.events.Event;
	
	/**
	 * 
	 * Base operation for work with Collection of Twitter Direct Messages
	 * @author Denis Borisenko
	 * 
	 */
	public class DirectMessagesOperation extends TwitterOperation
	{
		private var isSent:Boolean = false;
		
		public function DirectMessagesOperation(url:String, isSent:Boolean=false, 
			requiresAuthentication:Boolean=true)
		{
			super(url, requiresAuthentication);
			
			this.isSent = isSent;
		}
		
		/**
		 * 
		 * Collection of Twitter Direct Messages, received by the operation. 
		 * 
		 */
		[Bindable]
		public function get directMessages():DirectMessagesCollection
		{
			return data as DirectMessagesCollection;
		}
		public function set directMessages(value:DirectMessagesCollection):void
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
			var xml:XML = getXML();
        	if (xml.name() == "direct-messages")
        	{
	        	directMessages = new DirectMessagesCollection();
	        	
	            for each (var item:XML in xml.direct_message)
	        	{
	        		var dm:TwitterDirectMessage = new TwitterDirectMessage(item);
	        		dm.isSent = isSent;
	        		directMessages.addItem(dm);
	        	}
        	}
            super.handleResult(event);
        }
	}
}
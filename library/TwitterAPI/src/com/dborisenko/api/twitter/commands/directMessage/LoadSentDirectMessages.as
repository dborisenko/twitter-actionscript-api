/** LoadSentDirectMessages.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.directMessage
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.net.DirectMessagesOperation;
	
	/**
	 * Returns a list of the 20 most recent direct messages sent by the authenticating user.  
	 * The XML and JSON versions include detailed information about the sending and recipient users. 
	 * 
	 * @author Denis Borisenko
	 * @see https://dev.twitter.com/docs/api/1/get/direct_messages/sent
	 */
	public class LoadSentDirectMessages extends DirectMessagesOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "https://api.twitter.com/1/direct_messages/sent.json";
		
		/**
		 * 
		 * @param sinceId		Optional.  Returns only direct messages with an ID greater than 
		 * 						(that is, more recent than) the specified ID. 
		 * 						Example: since_id=12345
		 * @param maxId			Optional.  Returns only statuses with an ID less than (that is, older than) 
		 * 						or equal to the specified ID.
		 * 						Example: max_id=54321 
		 * @param count			Optional.  Specifies the number of direct messages to retrieve. May not be greater than 200.  
		 * 						Example: count=5
		 * 
		 * @param entities      Optional. Whether or not to include entities in the response statuses.
		 * 
		 */
		public function LoadSentDirectMessages(sinceId:String=null, maxId:String=null, count:int=-1, entities:Boolean = true)
		{
			super(URL, true);
			resultFormat = ResultFormat.JSON;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
			parameters = {since_id: sinceId, max_id: maxId, count: count, include_entities:entities};
		}
	}
}
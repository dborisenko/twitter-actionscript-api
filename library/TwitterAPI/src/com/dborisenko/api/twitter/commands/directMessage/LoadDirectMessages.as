/** LoadDirectMessages.as
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
	 * Returns a list of the 20 most recent direct messages sent to the authenticating user.  
	 * The XML and JSON versions include detailed information about the sending and recipient users.
	 *  
	 * @author Denis Borisenko
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-direct_messages
	 */
	public class LoadDirectMessages extends DirectMessagesOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "http://twitter.com/direct_messages.xml";
		
		/**
		 * 
		 * @param sinceId		Optional.  Returns only direct messages with an ID greater than 
		 * 						(that is, more recent than) the specified ID.
		 * 						Example: since_id=12345
		 * @param maxId			Optional.Returns only statuses with an ID less than (that is, older than) 
		 * 						or equal to the specified ID.
		 * 						Example: max_id=54321 
		 * @param count			Optional.  Specifies the number of statuses to retrieve. May not be greater than 200.  
		 * 						Example: count=200
		 * @param page			Optional. Specifies the page of direct messages to retrieve. 
		 * 						Example: page=3
		 * 
		 */
		public function LoadDirectMessages(sinceId:String=null, maxId:String=null, count:int=-1, page:int=-1)
		{
			super(URL);
			resultFormat = ResultFormat.XML;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
			parameters = {since_id: sinceId, max_id: maxId, count: count, page: page};
		}
	}
}
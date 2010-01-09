/** GetListSubscriptions.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 */
package com.dborisenko.api.twitter.commands.list
{
	import com.dborisenko.api.twitter.net.ListsOperation;
	
	/**
	 * List the lists the specified user follows.
	 * 
	 * @author Denis Borisenko
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-GET-list-subscriptions
	 */
	public class GetListSubscriptions extends ListsOperation
	{
		protected static const URL:String = "http://api.twitter.com/1/{user}/lists/subscriptions.xml";
		
		/**
		 * 
		 * @param cursor			Optional. Breaks the results into pages. A single page contains 20 lists. 
		 * 							Provide a value of -1 to begin paging. Provide values as returned to in the response 
		 * 							body's next_cursor and previous_cursor attributes to page back and forth in the list.
		 * 								Example: cursor=-1
		 * 								Example: cursor=-1300794057949944903
		 * 
		 */
		public function GetListSubscriptions(user:String, cursor:String=null)
		{
			super(URL.replace(/\{user\}/gi, user));
			resultFormat = RESULT_FORMAT_XML;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
			parameters = {cursor: cursor};
		}
	}
}
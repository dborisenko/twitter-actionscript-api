/** LoadListsOfUser.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.list
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.interfaces.IPagingOperation;
	import com.dborisenko.api.twitter.net.ListsOperation;
	
	/**
	 * List the lists of the specified user. 
	 * Private lists will be included if the authenticated users is the same as the user who'se lists are being returned.
	 * 
	 * @author Denis Borisenko
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-GET-lists
	 */
	public class LoadListsOfUser extends ListsOperation implements IPagingOperation
	{
		protected static const URL:String = "http://api.twitter.com/1/{user}/lists.xml";
		
		/**
		 * 
		 * @param user
		 * @param cursor		Optional. Breaks the results into pages. A single page contains 20 lists. 
		 * 						Provide a value of -1 to begin paging. Provide values as returned to in the 
		 * 						response body's next_cursor and previous_cursor attributes to page back and forth 
		 * 						in the list.
		 * 							Example: cursor=-1
		 * 							Example: cursor=-1300794057949944903
		 * 
		 */
		public function LoadListsOfUser(user:String, cursor:String="-1")
		{
			super(URL.replace(/\{user\}/gi, user));
			resultFormat = ResultFormat.XML;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
			parameters = {cursor: cursor};
		}
		
		public function get cursor():String
		{
			return parameters["cursor"];
		}
		public function set cursor(value:String):void
		{
			if (value)
			{
				parameters["cursor"] = value;
			}
			else if (parameters["cursor"])
			{
				delete parameters["cursor"];
			}
		}
	}
}
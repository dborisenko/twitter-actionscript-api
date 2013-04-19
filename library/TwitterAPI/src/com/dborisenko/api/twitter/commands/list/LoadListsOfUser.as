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
	 * Private lists will be included if the authenticated user is the same as the user whose lists are being returned.
	 * 
	 * @author Denis Borisenko
	 * @see https://dev.twitter.com/docs/api/1/get/lists
	 */
	public class LoadListsOfUser extends ListsOperation implements IPagingOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "https://api.twitter.com/1/lists.json";
		
		/**
		 * 
		 * Either screenName or userId is required.
		 * 
		 * @param userId        Optional. The ID of the user for whom to return results for.
		 * 
		 * @param screenName    Optional. The screen name of the user for whom to return results for.
		 * 
		 * @param cursor		Optional. Breaks the results into pages. A single page contains 20 lists. 
		 * 						  Provide a value of -1 to begin paging. Provide values as returned to in the 
		 * 						  response body's next_cursor and previous_cursor attributes to page back and forth 
		 * 						  in the list.
		 * 							Example: cursor=-1
		 * 							Example: cursor=-1300794057949944903
		 * 
		 */
		public function LoadListsOfUser(userId:String = null, screenName:String = null, cursor:String = "-1")
		{
			super(URL);
			resultFormat = ResultFormat.JSON;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
			parameters = {user_id:userId, screen_name:screenName, cursor: cursor};
		}
		
		/**
		 * 
		 * Optional. Breaks the results into pages. A single page contains 20 lists. 
		 * Provide a value of -1 to begin paging. Provide values as returned to in the 
		 * response body's next_cursor and previous_cursor attributes to page back and forth 
		 * in the list.
		 * 		Example: cursor=-1
		 * 		Example: cursor=-1300794057949944903 
		 * 
		 */
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
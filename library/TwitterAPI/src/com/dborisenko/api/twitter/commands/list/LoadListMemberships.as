/** GetListMemberships.as
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
	 * List the lists the specified user has been added to.
	 * 
	 * If user_id or screen_name are not provided the memberships for the authenticating user are returned.
	 * 
	 * @author Denis Borisenko
	 * @see https://dev.twitter.com/docs/api/1/get/lists/memberships
	 */
	public class LoadListMemberships extends ListsOperation implements IPagingOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "https://api.twitter.com/1/lists/memberships.json";
		
		/**
		 * 
		 * @param userId        Optional. The id of the user for whom to return results for. If blank, defaults to authenticated user.
		 * 
		 * @param screenName    Optional. The screen name of the whom to return results for. If blank, defaults to authenticated user.
		 * 
		 * @param cursor		Optional. Breaks the results into pages. A single page contains 20 lists. 
		 * 						  Provide a value of -1 to begin paging. Provide values as returned to in the response 
		 * 						  body's next_cursor and previous_cursor attributes to page back and forth in the list.
		 * 							  Example: cursor=-1
		 * 							  Example: cursor=-1300794057949944903
		 * 
		 * @param ownedLists   Optional. When set to true will return just lists the authenticating user owns and the user represented
		 *                        by userId or screenName is a member of.
		 * 
		 */
		public function LoadListMemberships(userId:String = null, screenName:String = null, cursor:String = "-1", ownedLists:Boolean = false)
		{
			super(URL);
			resultFormat = ResultFormat.JSON;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
			parameters = {user_id:userId, screen_name:screenName, cursor: cursor, filter_to_owned_lists:ownedLists};
		}
		
		/**
		 * 
		 * Optional. Breaks the results into pages. A single page contains 20 lists. 
		 * Provide a value of -1 to begin paging. Provide values as returned to in the response 
		 * body's next_cursor and previous_cursor attributes to page back and forth in the list.
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
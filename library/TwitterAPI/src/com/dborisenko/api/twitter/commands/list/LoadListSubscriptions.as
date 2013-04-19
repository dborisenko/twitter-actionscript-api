/** GetListSubscriptions.as
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
	 * List the lists the specified user follows.
	 * 
	 * @author Denis Borisenko
	 * @see https://dev.twitter.com/docs/api/1/get/lists/subscriptions
	 */
	public class LoadListSubscriptions extends ListsOperation implements IPagingOperation
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
		 * @param count         Optional. the amount of results per page. Defaults to 20, maximum of 1,000.
		 * 
		 * @param cursor		Optional. Breaks the results into pages. A single page contains 20 lists. 
		 * 						  Provide a value of -1 to begin paging. Provide values as returned to in the response 
		 * 						  body's next_cursor and previous_cursor attributes to page back and forth in the list.
		 * 							  Example: cursor=-1
		 * 							  Example: cursor=-1300794057949944903
		 * 
		 * 
		 * 
		 */
		public function LoadListSubscriptions(userId:String = null, screenName:String = null, count:int = -1, cursor:String="-1")
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
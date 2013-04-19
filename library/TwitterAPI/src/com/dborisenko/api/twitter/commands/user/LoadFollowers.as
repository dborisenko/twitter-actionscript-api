/** LoadFollowers.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.user
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.interfaces.IPagingOperation;
	import com.dborisenko.api.twitter.net.UsersOperation;
	
	/**
	 * 
	 * NOTE: The previous command, http://twitter.com/statuses/followers.xml, has been deprecated. Instead we have
	 * to use a new command that just gets the ids (up to 5,000) of the followers. From there a cursor can navigate
	 * the responses. We can then use the users/lookup command to get the details of up to 100 users at a time.
	 * 
	 * 
	 * @author Denis Borisenko
	 * @see https://dev.twitter.com/docs/api/1/get/followers/ids
	 */
	public class LoadFollowers extends UsersOperation implements IPagingOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "http://api.twitter.com/1/followers/ids.json";
		
		/**
		 * 
		 * @param userId		Optional.  Specfies the ID of the user for whom to return the list of followers. 
		 * 						Helpful for disambiguating when a valid user ID is also a valid screen name.
		 * 						Example: user_id=1401881
		 * @param screenName	Optional.  Specfies the screen name of the user for whom to return the list of followers. 
		 * 						Helpful for disambiguating when a valid screen name is also a user ID.
		 * 						Example: screen_name=101010
		 * @param cursor		Optional. Breaks the results into pages. A single page contains 100 users. 
		 * 						This is recommended for users who are followed by many other users. Provide a value 
		 * 						of  -1 to begin paging. Provide values as returned to in the response body's next_cursor 
		 * 						and previous_cursor attributes to page back and forth in the list.
		 * 						Example: cursor=-1 or cursor=1300794057949944903
		 * 
		 * @param stringIds     Optional. returns the IDs as strings instead of ints. Defaults to true because I'm not
		 *                        sure if Flash can handle the larger numbers.
		 * 
		 */
		public function LoadFollowers(userId:String=null, screenName:String=null, cursor:String="-1", stringIds:Boolean = true)
		{
			super(URL, true);
			resultFormat = ResultFormat.JSON;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
			parameters = {user_id: userId, screen_name: screenName, cursor: cursor, stringify_ids:stringIds}
		}
		
		/**
		 * 
		 * Optional. Breaks the results into pages. A single page contains 5000 user Ids. 
		 * This is recommended for users who are followed by many other users. Provide a value 
		 * of  -1 to begin paging. Provide values as returned to in the response body's next_cursor 
		 * and previous_cursor attributes to page back and forth in the list.
		 * Example: cursor=-1 or cursor=1300794057949944903
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
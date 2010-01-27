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
	 * Returns the authenticating user's followers, each with current status inline.  They are ordered by the order 
	 * in which they followed the user, 100 at a time. (Please note that the result set isn't guaranteed to be 100 
	 * every time as suspended users will be filtered out.) Use the cursor option to access earlier followers.
	 * 
	 * @author Denis Borisenko
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-statuses%C2%A0followers
	 */
	public class LoadFollowers extends UsersOperation implements IPagingOperation
	{
		protected static const URL:String = "http://twitter.com/statuses/followers.xml";
		
		/**
		 * 
		 * @param id			Optional.  The ID or screen name of the user for whom to request a list of followers. 
		 * 						Example: 12345 or bob
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
		 */
		public function LoadFollowers(id:String=null, userId:String=null, screenName:String=null, cursor:String="-1")
		{
			super(URL, true);
			resultFormat = ResultFormat.XML;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
			parameters = {id: id, user_id: userId, screen_name: screenName, cursor: cursor}
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
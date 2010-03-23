/** DestroyFriendships.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.friendship
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.net.UserOperation;
	
	/**
	 * Allows the authenticating users to unfollow the user specified in the ID parameter.  
	 * Returns the unfollowed user in the requested format when successful.  
	 * Returns a string describing the failure condition when unsuccessful.
	 * 
	 * @author Denis Borisenko
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-friendships%C2%A0destroy
	 */
	public class DestroyFriendships extends UserOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "http://twitter.com/friendships/destroy/{id}.xml";
		
		/**
		 * One of the following is required:
		 * 
		 * @param id			Required. The ID or screen name of the user to unfollow.  
		 * 						Example: 12345 or bob
		 * @param userId		Required. Specfies the ID of the user to unfollow. 
		 * 						Helpful for disambiguating when a valid user ID is also a valid screen name. 
		 * 						Example: user_id=1401881
		 * @param screenName	Required. Specfies the screen name of the user to unfollow. 
		 * 						Helpful for disambiguating when a valid screen name is also a user ID. 
		 * 						Example: screen_name=101010
		 * 
		 */
		public function DestroyFriendships(id:String, userId:String=null, screenName:String=null)
		{
			super(URL.replace(/\{id\}/gi, id));
			resultFormat = ResultFormat.XML;
			method = METHOD_POST;
			_requiresAuthentication = true;
			_apiRateLimited = false;
			parameters = {id: id, user_id: userId, screen_name: screenName};
		}
	}
}
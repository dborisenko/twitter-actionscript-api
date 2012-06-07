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
	 * @see https://dev.twitter.com/docs/api/1/post/friendships/destroy
	 */
	public class DestroyFriendships extends UserOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "http://api.twitter.com/1/friendships/destroy.json";
		
		/**
		 * One of userId or screenName is required:
		 * @param userId	    Optional. Specfies the ID of the user to unfollow. 
		 * 						Helpful for disambiguating when a valid user ID is also a valid screen name. 
		 * 						Example: user_id=1401881
		 * 
		 * @param screenName	Optional. Specfies the screen name of the user to unfollow. 
		 * 						Helpful for disambiguating when a valid screen name is also a user ID. 
		 * 						Example: screen_name=101010
		 * 
		 * @param entities      Optional. Whether or not to include entities in the status tweets returned.
		 * 
		 */
		public function DestroyFriendships(userId:String = null, screenName:String = null, entities:Boolean = true)
		{
			super(URL);
			resultFormat = ResultFormat.JSON;
			method = METHOD_POST;
			_requiresAuthentication = true;
			_apiRateLimited = false;
			parameters = {user_id: userId, screen_name: screenName, include_entities:entities};
		}
	}
}
/** CreateFriendships.as
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
	 * Allows the authenticating users to follow the user specified in the ID parameter.  
	 * Returns the befriended user in the requested format when successful.  
	 * Returns a string describing the failure condition when unsuccessful. 
	 * If you are already friends with the user an HTTP 403 will be returned.
	 * 
	 * @author Denis Borisenko
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-friendships%C2%A0create
	 * @see http://apiwiki.twitter.com/HTTP-Response-Codes-and-Errors
	 */
	public class CreateFriendships extends UserOperation
	{
		protected static const URL:String = "http://twitter.com/friendships/create/{id}.xml";
		
		/**
		 * One of the id, user_id or screen_name is required
		 * @param id			Required. The ID or screen name of the user to befriend. 
		 * 						Example: 12345 or bob
		 * @param userId		Required. Specfies the ID of the user to befriend. 
		 * 						Helpful for disambiguating when a valid user ID is also a valid screen name. 
		 * 						Example: user_id=1401881
		 * @param screenName	Required. Specfies the screen name of the user to befriend. 
		 * 						Helpful for disambiguating when a valid screen name is also a user ID. 
		 * 						Example: screen_name=101010
		 * @param follow		Optional. Enable notifications for the target user in addition to becoming friends. 
		 * 						Example: follow=true
		 * 
		 */
		public function CreateFriendships(id:String, userId:String=null, screenName:String=null, follow:String=null)
		{
			super(URL.replace(/\{id\}/gi, id));
			resultFormat = ResultFormat.XML;
			method = METHOD_POST;
			_requiresAuthentication = true;
			_apiRateLimited = false;
			parameters = {id: id, user_id: userId, screen_name: screenName, follow:follow};
		}
	}
}
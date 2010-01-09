/** LoadUserInfo.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.user
{
	import com.dborisenko.api.twitter.net.UserOperation;
	
	/**
	 * Returns extended information of a given user, specified by ID or screen name as per the required id parameter.  
	 * The author's most recent status will be returned inline.
	 * 
	 * @author Denis Borisenko
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-users%C2%A0show
	 */
	public class LoadUserInfo extends UserOperation
	{
		protected static const URL:String = "http://twitter.com/users/show.xml";
		
		/**
		 * 
		 * @param id			The ID or screen name of a user.
		 * 						Example: 12345 or bob
		 * @param userId		Specfies the ID of the user to return. Helpful for disambiguating 
		 * 						when a valid user ID is also a valid screen name.
		 * 						Example: user_id=1401881
		 * @param screenName	Specfies the screen name of the user to return. Helpful for disambiguating 
		 * 						when a valid screen name is also a user ID.
		 * 						Example: screen_name=101010
		 * 
		 */
		public function LoadUserInfo(id:String, userId:String=null, screenName:String=null)
		{
			super(URL);
			resultFormat = RESULT_FORMAT_XML;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
			parameters = {id: id, user_id: userId, screen_name: screenName};
		}
	}
}
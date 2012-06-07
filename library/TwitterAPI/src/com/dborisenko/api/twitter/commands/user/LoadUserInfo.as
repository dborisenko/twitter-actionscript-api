/** LoadUserInfo.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.user
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.net.UserOperation;
	
	/**
	 * Returns extended information of a given user, specified by ID or screen name as per the required id parameter.  
	 * The author's most recent status will be returned inline.
	 * 
	 * @author Denis Borisenko
	 * @see https://dev.twitter.com/docs/api/1/get/users/show
	 */
	public class LoadUserInfo extends UserOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "http://api.twitter.com/version/users/show.json";
		
		/**
		 * userId or screenName is required.
		 * 
		 * @param userId		Specfies the ID of the user to return. Helpful for disambiguating 
		 * 						when a valid user ID is also a valid screen name.
		 * 						Example: user_id=1401881
		 * @param screenName	Specfies the screen name of the user to return. Helpful for disambiguating 
		 * 						when a valid screen name is also a user ID.
		 * 						Example: screen_name=101010
		 * 
		 * @param entities      Optional. Whether or not to include entities in the user's status.
		 */
		public function LoadUserInfo(userId:String = null, screenName:String = null, entities:Boolean = true)
		{
			super(URL);
			resultFormat = ResultFormat.JSON;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
			parameters = {user_id: userId, screen_name: screenName, include_entities:entities};
		}
	}
}
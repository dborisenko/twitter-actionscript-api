/** LoadFavorites.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.favorite
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.net.StatusesOperation;
	
	/**
	 * Returns the 20 most recent favorite statuses for the authenticating user or user 
	 * specified by the ID parameter in the requested format.
	 * 
	 * @author Denis Borisenko
	 * @see https://dev.twitter.com/docs/api/1/get/favorites
	 */
	public class LoadFavorites extends StatusesOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "https://api.twitter.com/1/favorites.json";
		
		/**
		 * 
		 * @param id		Optional.  The ID or screen name of the user for whom to request a list of favorite statuses. 
		 * @param page		Optional. Specifies the page of favorites to retrieve.
		 * 
		 */
		public function LoadFavorites(userId:String = null, screenName:String = null, count:int = 200, sinceId:String = null,
										maxId:String = null, entities:Boolean = true)
		{
			super(URL);
			resultFormat = ResultFormat.JSON;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
			parameters = {user_id: userId, screen_name:screenName, count:count, since_id:sinceId, max_id:maxId, include_entities:entities};
		}
	}
}
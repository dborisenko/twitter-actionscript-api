/** DestroyBlock.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.block
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.net.UserOperation;
	
	/**
	 * Un-blocks the user specified in the ID parameter for the authenticating user.  
	 * Returns the un-blocked user in the requested format when successful.
	 *   
	 * @author Denis Borisenko
	 * @see https://dev.twitter.com/docs/api/1/post/blocks/destroy
	 */
	public class DestroyBlock extends UserOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "https://api.twitter.com/1/blocks/destroy.json";
		
		/**
		 * One of the following parameters is required
		 * @param userId		Optional.  Specfies the ID of the potentially blocked user. 
		 * 						Helpful for disambiguating when a valid user ID is also a valid screen name.
		 * 						Example: user_id=1401881
		 * @param screenName	Optional.  Specfies the screen name of the potentially blocked user. 
		 * 						Helpful for disambiguating when a valid screen name is also a user ID.
		 * 						Example: screen_name=101010
		 * 
		 * @param entities      Optional. Whether or not to return entities in the response.
		 * 
		 * @param skip_status   Optional. Whether or not to include statuses with the returned user object.
		 * 
		 */
		public function DestroyBlock(userId:String, screenName:String = null, entities:Boolean = true, skipStatus:Boolean = false)
		{
			super(URL);
			resultFormat = ResultFormat.JSON;
			method = METHOD_POST;
			_requiresAuthentication = true;
			_apiRateLimited = false;
			parameters = {user_id: userId, screen_name: screenName, include_entities:entities, skip_status:skipStatus};
		}
	}
}
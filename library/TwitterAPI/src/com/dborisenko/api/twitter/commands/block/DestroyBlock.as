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
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-blocks%C2%A0destroy
	 */
	public class DestroyBlock extends UserOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "http://twitter.com/blocks/destroy/{id}.xml";
		
		/**
		 * One of the following parameters is required
		 * @param id 			Optional.  The ID or screen_name of the potentially blocked user.
		 * 						Example: id=bob
		 * @param userId		Optional.  Specfies the ID of the potentially blocked user. 
		 * 						Helpful for disambiguating when a valid user ID is also a valid screen name.
		 * 						Example: user_id=1401881
		 * @param screenName	Optional.  Specfies the screen name of the potentially blocked user. 
		 * 						Helpful for disambiguating when a valid screen name is also a user ID.
		 * 						Example: screen_name=101010
		 * 
		 */
		public function DestroyBlock(id:String, userId:String=null, screenName:String=null)
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
/** LoadBlockedUsers.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.block
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.net.UsersOperation;
	
	/**
	 * Returns an array of user objects that the authenticating user is blocking.
	 *  
	 * @author Denis Borisenko
	 * @see https://dev.twitter.com/docs/api/1/get/blocks/blocking
	 */
	public class LoadBlockedUsers extends UsersOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "http://api.twitter.com/1/blocks/blocking.json";
		
		/**
		 * 
		 * @param page			Optional. Specifies the page number of the results beginning at 1. 
		 * 						A single page contains 20 ids.
		 * 						Example: page=1
		 * 
		 * @param perPage       Optional. Number of results per page. Docs don't specify a limit...
		 * 
		 * @param entities      Optional. Whether or not to include entities in response.
		 * 
		 * @param skipStatus    Optional. Whether or not to skip user statuses in response.
		 * 
		 * 
		 * 
		 */
		public function LoadBlockedUsers(page:int = -1, perPage:int = 20, entities:Boolean = true, skipStatus:Boolean = false)
		{
			super(URL, false, true);
			resultFormat = ResultFormat.JSON;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
			parameters = {page: page, per_page:perPage, include_entities:entities, skip_status:skipStatus};
		}
	}
}
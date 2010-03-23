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
	 * @see http://apiwiki.twitter.com/Twitter+REST+API+Method%3A-blocks-blocking
	 */
	public class LoadBlockedUsers extends UsersOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "http://twitter.com/blocks/blocking.xml";
		
		/**
		 * 
		 * @param page			Optional. Specifies the page number of the results beginning at 1. 
		 * 						A single page contains 20 ids.
		 * 						Example: page=1
		 * 
		 */
		public function LoadBlockedUsers(page:int=-1)
		{
			super(URL, false, true);
			resultFormat = ResultFormat.XML;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
			parameters = {page: page};
		}
	}
}
/** NewDirectMessage.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.directMessage
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.net.DirectMessageOperation;
	
	/**
	 * Sends a new direct message to the specified user from the authenticating user. 
	 * Requires both the user and text parameters. Request must be a POST. 
	 * Returns the sent message in the requested format when successful.
	 * 
	 * @author Denis Borisenko
	 * @see https://dev.twitter.com/docs/api/1/post/direct_messages/new
	 */
	public class NewDirectMessage extends DirectMessageOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "https://api.twitter.com/1/direct_messages/new.json";
		
		/**
		 * One of either the userId or the screenName must be sent.
		 * 
		 * @param userId            Optional. The Id of the User to send the tweet to.
		 * 
		 * @param screenName        Optional. The screen name of the User to sent the tweet to.
		 * 
		 * @param text				Required.  The text of your direct message.  Be sure to URL encode as necessary, 
		 * 							and keep it under 140 characters.
		 * 
		 */
		public function NewDirectMessage(userId:String = null, screenName:String = null, text:String = "")
		{
			super(URL, true, null, true);
			resultFormat = ResultFormat.JSON;
			method = METHOD_POST;
			_requiresAuthentication = true;
			_apiRateLimited = false;
			parameters = { user_id:userId, screen_name: screenName, text: text};
		}
	}
}
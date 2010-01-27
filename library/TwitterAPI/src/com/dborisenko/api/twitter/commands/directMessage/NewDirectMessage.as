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
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-direct_messages%C2%A0new
	 */
	public class NewDirectMessage extends DirectMessageOperation
	{
		protected static const URL:String = "http://twitter.com/direct_messages/new.xml";
		
		/**
		 * 
		 * @param recipient			user:  Required.  The ID or screen name of the recipient user. 
		 * 							In order to support numeric screen names we will accept either of the following 
		 * 							two parameters in place of the user parameter:
		 * 								* screen_name: screen name of the recipient user
		 * 								* user_id: user id of the recipient user
		 * @param text				Required.  The text of your direct message.  Be sure to URL encode as necessary, 
		 * 							and keep it under 140 characters.
		 * 
		 */
		public function NewDirectMessage(recipient:Object, text:String)
		{
			super(URL, true, null, true);
			resultFormat = ResultFormat.XML;
			method = METHOD_POST;
			_requiresAuthentication = true;
			_apiRateLimited = false;
			parameters = {user: getScreenName(recipient), text: text};
		}
	}
}
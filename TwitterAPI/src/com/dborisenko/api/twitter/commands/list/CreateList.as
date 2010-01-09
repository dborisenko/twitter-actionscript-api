/** CreateList.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.list
{
	import com.dborisenko.api.twitter.net.ListOperation;
	
	/**
	 * Creates a new list for the authenticated user. Accounts are limited to 20 lists. 
	 * 
	 * @author Denis Borisenko
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-POST-lists
	 */
	public class CreateList extends ListOperation
	{
		protected static const URL:String = "http://api.twitter.com/1/{user}/lists.xml";
		
		/**
		 * 
		 * @param user
		 * @param name				Required.  The name of the list you are creating.
		 * @param mode				Optional. Whether your list is public or private. 
		 * 							Values can be public or private. Lists are public by default if no mode is specified.
		 * @param description		Optional.  The description of the list you are creating.
		 * 
		 */
		public function CreateList(user:String, name:String, mode:String=null, description:String=null)
		{
			super(URL.replace(/\{user\}/gi, user));
			resultFormat = RESULT_FORMAT_XML;
			method = METHOD_POST;
			_requiresAuthentication = true;
			_apiRateLimited = false;
			parameters = {name: name, mode: mode, description: description};
		}
	}
}
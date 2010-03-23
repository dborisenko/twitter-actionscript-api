/** UpdateList.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.list
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.net.ListOperation;
	
	/**
	 * Updates the specified list. 
	 * 
	 * @author Denis Borisenko
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-POST-lists-id
	 */
	public class UpdateList extends ListOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "http://api.twitter.com/1/{user}/lists/{id}.xml";
		
		/**
		 * 
		 * @param user
		 * @param id
		 * @param name				Optional. What you'd like to change the lists name to.
		 * @param mode				Optional. Whether your list is public or private. Values can be public or private. 
		 * 							Lists are public by default if no mode is specified.
		 * @param description		Optional.  What you'd like to change the list description to.
		 * 
		 */
		public function UpdateList(user:String, id:String, name:String, mode:String=null, description:String=null)
		{
			super(URL.replace(/\{id\}/gi, id).replace(/\{user\}/gi, user));
			resultFormat = ResultFormat.XML;
			method = METHOD_POST;
			_requiresAuthentication = true;
			_apiRateLimited = false;
			parameters = {name: name, mode: mode, description: description};
		}
	}
}
/** DestroyList.as
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
	 * Deletes the specified list. Must be owned by the authenticated user. 
	 * 
	 * @author Denis Borisenko
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-DELETE-list-id
	 */
	public class DestroyList extends ListOperation
	{
		protected static const URL:String = "http://api.twitter.com/1/{user}/lists/{id}.xml";
		
		/**
		 * 
		 * @param user
		 * @param id		Required. The id or slug of the list.
		 * 
		 */
		public function DestroyList(user:String, id:String)
		{
			super(URL.replace(/\{id\}/gi, id).replace(/\{user\}/gi, user));
			resultFormat = ResultFormat.XML;
			method = METHOD_DELETE;
			_requiresAuthentication = true;
			_apiRateLimited = false;
		}
	}
}
/** ShowList.as
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
	 * Show the specified list. Private lists will only be shown if the authenticated user owns the specified list.
	 * 
	 * @author Denis Borisenko
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-GET-list-id
	 */
	public class ShowList extends ListOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "http://api.twitter.com/1/{user}/lists/{id}.xml";
		
		/**
		 * 
		 * @param user
		 * @param id		Required. The id or slug of the list.
		 * 
		 */
		public function ShowList(user:String, id:String)
		{
			super(URL.replace(/\{id\}/gi, id).replace(/\{user\}/gi, user));
			resultFormat = ResultFormat.XML;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = false;
			parameters = {id: id};
		}
	}
}
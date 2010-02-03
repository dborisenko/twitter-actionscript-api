/** SubscribeList.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2010.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.listSubscribers
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.net.ListOperation;
	
	/**
	 * Make the authenticated user follow the specified list.
	 * 
	 * @author Denis Borisenko
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method:-POST-list-subscribers
	 */
	public class SubscribeList extends ListOperation
	{
		protected static const URL:String = "http://api.twitter.com/1/{user}/{list_id}/subscribers.xml";
		
		/**
		 * 
		 * @param user
		 * @param listId			Required. The id or slug of the list.
		 * 
		 */
		public function SubscribeList(user:String, listId:String)
		{
			super(URL.replace(/\{user\}/gi, user).replace(/\{list_id\}/gi, listId));
			resultFormat = ResultFormat.XML;
			method = METHOD_POST;
			_requiresAuthentication = true;
			_apiRateLimited = false;
			parameters = {list_id: listId};
		}
	}
}
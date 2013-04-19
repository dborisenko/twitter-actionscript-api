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
	 * @see https://dev.twitter.com/docs/api/1/post/lists/subscribers/create
	 */
	public class SubscribeList extends ListOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "https://api.twitter.com/1/lists/subscribers/create.json";
		
		/**
		 * Either a listId or a slug is required. If providing a slug, an ownerScreenName or ownerId is also required.
		 * 
		 * @param listId					Optional. The id or slug of the list.
		 * 
		 * @param slug                      Optional. The slug of the list. If used, ownerScreenName or ownerId is required.
		 * 
		 * @param ownerScreenName           Optional. The screen name of the owner.
		 * 
		 * @param ownerId                   Optional. The id of the owner.
		 * 
		 */
		public function SubscribeList(listId:String = null, slug:String = null, ownerScreenName:String = null, ownerId:String = null)
		{
			super(URL);
			resultFormat = ResultFormat.JSON;
			method = METHOD_POST;
			_requiresAuthentication = true;
			_apiRateLimited = false;
			parameters = {list_id: listId, slug:slug, owner_screen_name:ownerScreenName, owner_id:ownerId};
		}
	}
}
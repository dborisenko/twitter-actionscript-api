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
	 * @see https://dev.twitter.com/docs/api/1/get/lists/show
	 */
	public class ShowList extends ListOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "https://api.twitter.com/1/lists/show.json";
		
		/**
		 * Requires either a listId or a slug. If using the slug, you must pass either the ownerId or the ownerScreenName as well.
		 * 
		 * @param listId		       Optional. The id or slug of the list.
		 * @param slug                 Optional. The slug of the list.
		 * @param ownerId              Optional. The id of the Owner. needed if using a slug instead of a listId.
		 * @param ownerScreenName      Optional. The owner of the list. Needed if using slug instead of listId.
		 * 
		 */
		public function ShowList(listId:String = null, slug:String = null, ownerId:String = null, ownerScreenName:String = null)
		{
			super(URL);
			resultFormat = ResultFormat.JSON;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = false;
			parameters = {list_id:listId, slug:slug, owner_id:ownerId, owner_screen_name:ownerScreenName};
		}
	}
}
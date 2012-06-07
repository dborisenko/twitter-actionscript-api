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
	 * @see https://dev.twitter.com/docs/api/1/post/lists/update
	 */
	public class UpdateList extends ListOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "https://api.twitter.com/1/lists/update.json";
		
		
		/**
		 * Requires either a listId or a slug. If using the slug, you must pass either the ownerId or the ownerScreenName as well.
		 * 
		 * @param listId		       Optional. The id or slug of the list.
		 * @param slug                 Optional. The slug of the list.
		 * @param ownerId              Optional. The id of the Owner. needed if using a slug instead of a listId.
		 * @param ownerScreenName      Optional. The owner of the list. Needed if using slug instead of listId.
		 * @param name				   Optional. What you'd like to change the lists name to.
		 * @param mode				   Optional. Whether your list is public or private. Values can be public or private. 
		 * 						 	      Lists are public by default if no mode is specified.
		 * @param description		   Optional.  What you'd like to change the list description to.
		 * 
		 */
		
		public function UpdateList(listId:String = null, slug:String = null, ownerId:String = null, ownerScreenName:String = null,
								   name:String = null, mode:String = null, description:String = null)
		{
			super(URL);
			resultFormat = ResultFormat.JSON;
			method = METHOD_POST;
			_requiresAuthentication = true;
			_apiRateLimited = false;
			parameters = {list_id:listId, slug:slug, owner_screen_name:ownerScreenName, owner_id:ownerId, 
							name: name, mode: mode, description: description};
		}
	}
}
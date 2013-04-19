/** DeleteListMembers.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.listMembers
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.net.ListOperation;
	
	/**
	 * Removes the specified member from the list. The authenticated user must be the list's owner 
	 * to remove members from the list.
	 * 
	 * @author Denis Borisenko
	 * @see https://dev.twitter.com/docs/api/1/post/lists/members/destroy
	 */
	public class DeleteListMember extends ListOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "https://api.twitter.com/1/lists/members/destroy.json";
		
		/**
		 * Either userId or userScreen name is required.
		 * Either listId or slug is required. If using slug, the ownerId or ownerScreenName must also be passed.
		 * 
		 * @param userId	        		Optional. The id of the user to add as a member of the list.
		 * 
		 * @param userScreenName            Optional. The screenName of the user to add to the list.
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
		public function DeleteListMember(userId:String = null, userScreenName:String = null, listId:String = null, slug:String = null,
										 ownerScreenName:String = null, ownerId:String = null)
		{
			super(URL);
			resultFormat = ResultFormat.JSON;
			method = METHOD_POST;
			_requiresAuthentication = true;
			_apiRateLimited = false;
			parameters = {list_id:listId, slug:slug, user_id:userId, screen_name:userScreenName, 
				owner_screen_name:ownerScreenName, owner_id:ownerId};
		}
	}
}
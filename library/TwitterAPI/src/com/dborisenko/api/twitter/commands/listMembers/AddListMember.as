/** PostListMembers.as
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
	 * Add a member to a list. The authenticated user must own the list to be able to add members to it. 
	 * Lists are limited to having 500 members.
	 * 
	 * API Docs don't document what is returned here. I'm assuming the list that the user was added to.
	 * 
	 * @author Denis Borisenko
	 * @see https://dev.twitter.com/docs/api/1/post/lists/members/create
	 */
	public class AddListMember extends ListOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "https://api.twitter.com/1/lists/members/create.json";
		
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
		public function AddListMember(userId:String = null, userScreenName:String = null, listId:String = null, slug:String = null,
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
/** GetListMembers.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.listMembers
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.interfaces.IPagingOperation;
	import com.dborisenko.api.twitter.net.UsersOperation;
	
	/**
	 * Returns the members of the specified list. Private list members will only be shown if the authenticated user owns the specified list.
	 * 
	 * @author Denis Borisenko
	 * @see https://dev.twitter.com/docs/api/1/get/lists/members
	 */
	public class LoadListMembers extends UsersOperation implements IPagingOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "https://api.twitter.com/1/lists/members.json";
		
		/**
		 * 
		 * @param listId					Optional. The id or slug of the list.
		 * 
		 * @param slug                      Optional. The slug of the list. If used, ownerScreenName or ownerId is required.
		 * 
		 * @param ownerScreenName           Optional. The screen name of the owner.
		 * 
		 * @param ownerId                   Optional. The id of the owner.
		 * 
		 * @param cursor		            Optional. Breaks the results into pages. A single page contains 20 lists. 
		 * 						              Provide a value of -1 to begin paging. Provide values as returned to in the response 
		 * 						              body's next_cursor and previous_cursor attributes to page back and forth in the list.
		 * 							            Example: cursor=-1
		 * 							            Example: cursor=-1300794057949944903
		 * 
		 * @param entities                  Optional. Include entities in the user tweets.
		 * 
		 * @param skipStatus                Optional. Skip the status in returned users.
		 * 
		 */
		public function LoadListMembers(listId:String = null, slug:String = null, ownerScreenName:String = null, ownerId:String = null, 
										cursor:String = "-1", entities:Boolean = true, skipStatus:Boolean = false)
		{
			super(URL);
			resultFormat = ResultFormat.JSON;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
			parameters = {list_id: listId, slug:slug, owner_screen_name:ownerScreenName, owner_id:ownerId, cursor: cursor,
				include_entities:entities, skip_status:skipStatus};
		}
		
		/**
		 * 
		 * Optional. Breaks the results into pages. A single page contains 20 lists. 
		 * Provide a value of -1 to begin paging. Provide values as returned to in the response 
		 * body's next_cursor and previous_cursor attributes to page back and forth in the list.
		 * 		Example: cursor=-1
		 * 		Example: cursor=-1300794057949944903
		 * 
		 */
		public function get cursor():String
		{
			return parameters["cursor"];
		}
		public function set cursor(value:String):void
		{
			if (value)
			{
				parameters["cursor"] = value;
			}
			else if (parameters["cursor"])
			{
				delete parameters["cursor"];
			}
		}
	}
}
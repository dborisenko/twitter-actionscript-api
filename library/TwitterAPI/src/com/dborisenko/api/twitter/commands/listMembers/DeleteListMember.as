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
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-DELETE-list-members
	 */
	public class DeleteListMember extends ListOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "http://api.twitter.com/1/{user}/{list_id}/members.xml";
		
		/**
		 * 
		 * @param listId						Required. The id or slug of the list.
		 * @param userIdToDeleteFromList		Required. The id of the member you wish to remove from the list.
		 * 
		 */
		public function DeleteListMember(ownerUser:String, listId:String, userIdToDeleteFromList:String)
		{
			super(URL.replace(/\{user\}/gi, ownerUser).replace(/\{list_id\}/gi, listId));
			resultFormat = ResultFormat.XML;
			method = METHOD_DELETE;
			_requiresAuthentication = true;
			_apiRateLimited = false;
			parameters = {list_id: listId, id: userIdToDeleteFromList};
		}
	}
}
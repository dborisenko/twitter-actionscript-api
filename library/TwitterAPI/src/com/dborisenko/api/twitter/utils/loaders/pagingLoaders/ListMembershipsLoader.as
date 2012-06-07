/** ListMembershipsLoader.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2010.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.utils.loaders.pagingLoaders
{
	import com.dborisenko.api.twitter.TwitterAPI;
	import com.dborisenko.api.twitter.commands.list.LoadListMemberships;
	import com.dborisenko.api.twitter.net.TwitterOperation;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * List Memberships Loader class. Loads all the pages of the list memberships.
	 * @author Denis Borisenko
	 * 
	 */
	public class ListMembershipsLoader extends PagingLoader
	{
		protected var userId:String;
		protected var screenName:String;
		protected var ownedlists:Boolean = false;
		
		/**
		 * 
		 * @param userId        Optional. The id of the user for whom to return results for. If blank, defaults to authenticated user.
		 * 
		 * @param screenName    Optional. The screen name of the whom to return results for. If blank, defaults to authenticated user.
		 * 
		 * @param ownedLists   Optional. When set to true will return just lists the authenticating user owns and the user represented
		 *                        by userId or screenName is a member of.
		 * 
		 */
		public function ListMembershipsLoader(api:TwitterAPI,
											  userId:String = null, screenName:String = null, ownedLists:Boolean = false,
											  postType:String=TwitterAPI.POST_TYPE_NORMAL, 
											  priority:int=TwitterAPI.PRIORITY_NORMAL, list:ArrayCollection=null)
		{
			super(api, LoadListMemberships, postType, priority, list);
			this.userId = userId;
			this.screenName = screenName;
			this.ownedlists = ownedLists;
		}
		
		override protected function createOperation() : TwitterOperation
		{
			return new LoadListMemberships(userId, screenName, '-1', ownedlists);
		}
	}
}
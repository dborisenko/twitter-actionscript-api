/** ListsOfUserLoader.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2010.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.utils.loaders.pagingLoaders
{
	import com.dborisenko.api.twitter.TwitterAPI;
	import com.dborisenko.api.twitter.commands.list.LoadListsOfUser;
	import com.dborisenko.api.twitter.net.TwitterOperation;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * Lists of Users Loader class. Loads all the pages of the lists of users.
	 * @author Denis Borisenko
	 * 
	 */
	public class ListsOfUserLoader extends PagingLoader
	{
		protected var userId:String;
		protected var screenName:String;
		
		/**
		 * 
		 * Either screenName or userId is required.
		 * 
		 * @param userId        Optional. The ID of the user for whom to return results for.
		 * 
		 * @param screenName    Optional. The screen name of the user for whom to return results for.
		 * 
		 * 
		 */
		public function ListsOfUserLoader(api:TwitterAPI, 
										  userId:String = null, screenName:String = null,
										  postType:String=TwitterAPI.POST_TYPE_NORMAL,
										  priority:int=TwitterAPI.PRIORITY_NORMAL, list:ArrayCollection=null)
		{
			super(api, LoadListsOfUser, postType, priority, list);
			this.userId = userId;
			this.screenName = screenName;
		}
		
		override protected function createOperation() : TwitterOperation
		{
			return new LoadListsOfUser(userId, screenName, '-1');
		}
	}
}
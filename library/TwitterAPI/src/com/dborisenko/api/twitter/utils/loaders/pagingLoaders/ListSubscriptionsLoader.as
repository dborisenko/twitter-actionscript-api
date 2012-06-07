/** ListSubscriptionsLoader.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2010.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.utils.loaders.pagingLoaders
{
	import com.dborisenko.api.twitter.TwitterAPI;
	import com.dborisenko.api.twitter.commands.list.LoadListSubscriptions;
	import com.dborisenko.api.twitter.net.TwitterOperation;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * List Subscriptions Loader class. Loads all the pages of the list subscriptions.
	 * @author Denis Borisenko
	 * 
	 */
	public class ListSubscriptionsLoader extends PagingLoader
	{
		protected var userId:String;
		protected var screenName:String;
		protected var count:int;
		
		
		/**
		 * 
		 * @param userId        Optional. The id of the user for whom to return results for. If blank, defaults to authenticated user.
		 * 
		 * @param screenName    Optional. The screen name of the whom to return results for. If blank, defaults to authenticated user.
		 * 
		 * @param count         Optional. the amount of results per page. Defaults to 20, maximum of 1,000.
		 * 
		 */
		public function ListSubscriptionsLoader(api:TwitterAPI, 
												userId:String = null, screenName:String = null, count:int = -1,
												postType:String=TwitterAPI.POST_TYPE_NORMAL, 
												priority:int=TwitterAPI.PRIORITY_NORMAL, list:ArrayCollection=null)
		{
			super(api, LoadListSubscriptions, postType, priority, list);
			this.userId = userId;
			this.screenName = screenName;
			this.count = count;
		}
		
		override protected function createOperation() : TwitterOperation
		{
			return new LoadListSubscriptions(userId, screenName, count, '-1');
		}
	}
}
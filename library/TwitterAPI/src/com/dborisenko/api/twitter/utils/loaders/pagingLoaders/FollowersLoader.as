/** FollowersLoader.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.utils.loaders.pagingLoaders
{
	import com.dborisenko.api.twitter.TwitterAPI;
	import com.dborisenko.api.twitter.commands.user.LoadFollowers;
	import com.dborisenko.api.twitter.net.TwitterOperation;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * Followers Loader class. Loads all the pages of the followers.
	 * @author Denis Borisenko
	 * 
	 */
	public class FollowersLoader extends PagingLoader
	{
		
		protected var userId:String;
		protected var screenName:String;
		protected var stringIds:Boolean = true;
		
		/**
		 * @param API           Required. The API to execute this command against.
		 * 
		 * @param userId		Optional.  Specfies the ID of the user for whom to return the list of followers. 
		 * 						  Helpful for disambiguating when a valid user ID is also a valid screen name.
		 * 						  Example: user_id=1401881
		 * @param screenName	Optional.  Specfies the screen name of the user for whom to return the list of followers. 
		 *   						Helpful for disambiguating when a valid screen name is also a user ID.
		 * 	     					Example: screen_name=101010
		 * 
		 * @param stringIds     Optional. returns the IDs as strings instead of ints. Defaults to true because I'm not
		 *                        sure if Flash can handle the larger numbers.
		 * 
		 */
		public function FollowersLoader(api:TwitterAPI, 
										userId:String = null, screenName:String = null, stringIds:Boolean = true,
										postType:String=TwitterAPI.POST_TYPE_NORMAL, 
										priority:int=TwitterAPI.PRIORITY_NORMAL, list:ArrayCollection=null)
		{
			super(api, LoadFollowers, postType, priority, list);
			this.userId = userId;
			this.screenName = screenName;
			this.stringIds = stringIds;
		}
		
		public function get followersList():ArrayCollection
		{
			return list;
		}
		
		override protected function createOperation() : TwitterOperation
		{
			return new LoadFollowers(userId, screenName, "-1", stringIds) //cursor is overridden in PagingLoader.
		}
	}
}
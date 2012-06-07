/** FriendsLoader.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.utils.loaders.pagingLoaders
{
	import com.dborisenko.api.twitter.TwitterAPI;
	import com.dborisenko.api.twitter.commands.user.LoadFriends;
	import com.dborisenko.api.twitter.net.TwitterOperation;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * Friends Loader class. Loads all the pages of the friends.
	 * @author Denis Borisenko
	 * 
	 */
	public class FriendsLoader extends PagingLoader
	{
		protected var userId:String;
		protected var screenName:String;
		protected var stringIds:Boolean = true;
		
		
		
		/**
		 * You must provide either a userId or a screenName.
		 * 
		 * @param api           Required. The API to run command against.
		 * 
		 * @param userId		Optional.  Specfies the ID of the user for whom to return the list of friends. 
		 * 						Helpful for disambiguating when a valid user ID is also a valid screen name.
		 * 						Example: user_id=1401881
		 * 
		 * @param screenName	Optional.  Specfies the screen name of the user for whom to return the list of friends. 
		 * 						Helpful for disambiguating when a valid screen name is also a user ID.
		 * 						Example: screen_name=101010
		 * 
		 * @param stringIds     Optional. Whether or not to make the returned user ids into strings. This defaults
		 *                        to true because I'm not sure if Flash can handle the large numbers.
		 * 
		 */
		public function FriendsLoader(api:TwitterAPI, 
									  userId:String=null, screenName:String=null, stringIds:Boolean = true,
									  postType:String=TwitterAPI.POST_TYPE_NORMAL, 
									  priority:int=TwitterAPI.PRIORITY_NORMAL, list:ArrayCollection=null)
		{
			super(api, LoadFriends, postType, priority, list);
			this.userId = userId;
			this.screenName = screenName;
			this.stringIds = stringIds;
		}
		
		public function get friendsList():ArrayCollection
		{
			return list;
		}
		
		override protected function createOperation() : TwitterOperation
		{
			return new LoadFriends(userId, screenName, '-1', stringIds);
		}
	}
}
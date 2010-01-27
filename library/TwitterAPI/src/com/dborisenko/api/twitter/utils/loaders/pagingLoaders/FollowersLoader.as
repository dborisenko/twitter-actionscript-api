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
	
	public class FollowersLoader extends PagingLoader
	{
		protected var id:String;
		protected var userId:String;
		protected var screenName:String;
		
		public function FollowersLoader(api:TwitterAPI, 
										id:String=null, userId:String=null, screenName:String=null,
										postType:String=TwitterAPI.POST_TYPE_NORMAL, 
										priority:int=TwitterAPI.PRIORITY_NORMAL, list:ArrayCollection=null)
		{
			super(api, LoadFollowers, postType, priority, list);
			this.id = id;
			this.userId = userId;
			this.screenName = screenName;
		}
		
		public function get followersList():ArrayCollection
		{
			return list;
		}
		
		override protected function createOperation() : TwitterOperation
		{
			return new LoadFollowers(id, userId, screenName);
		}
	}
}
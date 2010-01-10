/** FollowersLoader.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.utils.loaders
{
	import com.dborisenko.api.twitter.TwitterAPI;
	import com.dborisenko.api.twitter.commands.user.LoadFollowers;
	
	import mx.collections.ArrayCollection;
	
	public class FollowersLoader extends PagingLoader
	{
		public function FollowersLoader(api:TwitterAPI, postType:String=TwitterAPI.POST_TYPE_NORMAL, 
										priority:int=TwitterAPI.PRIORITY_NORMAL, list:ArrayCollection=null)
		{
			super(api, LoadFollowers, postType, priority, list);
		}
		
		public function get followersList():ArrayCollection
		{
			return list;
		}
	}
}
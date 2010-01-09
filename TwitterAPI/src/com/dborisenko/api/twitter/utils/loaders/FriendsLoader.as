/** FriendsLoader.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.utils.loaders
{
	import com.dborisenko.api.twitter.TwitterAPI;
	import com.dborisenko.api.twitter.commands.user.LoadFriends;
	
	import mx.collections.ArrayCollection;
	
	public class FriendsLoader extends PagingLoader
	{
		public function FriendsLoader(api:TwitterAPI, postType:String=TwitterAPI.POST_TYPE_NORMAL, 
									  priority:int=TwitterAPI.PRIORITY_NORMAL, list:ArrayCollection=null)
		{
			super(api, LoadFriends, postType, priority, list);
		}
		
		public function get friendsList():ArrayCollection
		{
			return list;
		}
	}
}
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
	
	public class ListMembershipsLoader extends PagingLoader
	{
		protected var user:String;
		
		public function ListMembershipsLoader(api:TwitterAPI,
											  user:String,
											  postType:String=TwitterAPI.POST_TYPE_NORMAL, 
											  priority:int=TwitterAPI.PRIORITY_NORMAL, list:ArrayCollection=null)
		{
			super(api, LoadListMemberships, postType, priority, list);
			this.user = user;
		}
		
		override protected function createOperation() : TwitterOperation
		{
			return new LoadListMemberships(user);
		}
	}
}
/** ListMembershipsLoader.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2010.
 */
package com.dborisenko.api.twitter.utils.loaders
{
	import com.dborisenko.api.twitter.TwitterAPI;
	import com.dborisenko.api.twitter.commands.list.LoadListMemberships;
	
	import mx.collections.ArrayCollection;
	
	public class ListMembershipsLoader extends PagingLoader
	{
		public function ListMembershipsLoader(api:TwitterAPI, postType:String=TwitterAPI.POST_TYPE_NORMAL, 
											  priority:int=TwitterAPI.PRIORITY_NORMAL, list:ArrayCollection=null)
		{
			super(api, LoadListMemberships, postType, priority, list);
		}
	}
}
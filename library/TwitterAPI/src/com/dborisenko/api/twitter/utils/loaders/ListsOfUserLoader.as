package com.dborisenko.api.twitter.utils.loaders
{
	import com.dborisenko.api.twitter.TwitterAPI;
	import com.dborisenko.api.twitter.commands.list.LoadListsOfUser;
	
	import mx.collections.ArrayCollection;
	
	public class ListsOfUserLoader extends PagingLoader
	{
		public function ListsOfUserLoader(api:TwitterAPI, postType:String=TwitterAPI.POST_TYPE_NORMAL, 
								   priority:int=TwitterAPI.PRIORITY_NORMAL, list:ArrayCollection=null)
		{
			super(api, LoadListsOfUser, postType, priority, list);
		}
	}
}
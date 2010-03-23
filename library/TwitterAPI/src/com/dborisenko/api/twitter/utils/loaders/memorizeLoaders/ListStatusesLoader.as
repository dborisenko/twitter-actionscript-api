/** ListStatusesLoader.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2010.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.utils.loaders.memorizeLoaders
{
	import com.dborisenko.api.twitter.TwitterAPI;
	import com.dborisenko.api.twitter.commands.list.LoadListStatuses;
	import com.dborisenko.api.twitter.data.TwitterStatus;
	import com.dborisenko.api.twitter.net.TwitterOperation;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * List Statuses Loader class.
	 * @author Denis Borisenko
	 * 
	 */
	public class ListStatusesLoader extends MemorizeLoader
	{
		protected var user:String;
		protected var listId:String;
		protected var maxId:String;
		protected var perPage:int = -1;
		protected var page:int = -1;
				
		public function ListStatusesLoader(api:TwitterAPI, 
										   user:String, listId:String, sinceId:String=null, maxId:String=null, 
										   perPage:int=-1, page:int=-1,
										   postType:String=TwitterAPI.POST_TYPE_NORMAL, priority:int=TwitterAPI.PRIORITY_NORMAL)
		{
			super(api, LoadListStatuses, postType, priority);
			
			this.user = user;
			this.listId = listId;
			this.sinceId = sinceId;
			this.maxId = maxId;
			this.perPage = perPage;
			this.page = page;
		}
		
		override protected function readSinceId(data:Object) : String
		{
			if (data is ArrayCollection && ArrayCollection(data).length > 0)
			{
				var item:TwitterStatus = ArrayCollection(data).getItemAt(0) as TwitterStatus;
				if (item)
				{
					return item.id;
				}
			}
			return null;
		}
		
		override protected function createOperation() : TwitterOperation
		{
			return new LoadListStatuses(user, listId, sinceId, maxId, perPage, page);
		}
	}
}
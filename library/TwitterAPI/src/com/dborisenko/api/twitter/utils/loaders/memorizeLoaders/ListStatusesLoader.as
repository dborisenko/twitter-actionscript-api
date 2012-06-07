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
		protected var listId:String = null;
		protected var slug:String = null;
		protected var ownerScreenName:String = null;
		protected var ownerId:String = null;
		protected var maxId:String = null;
		protected var perPage:int = -1;
		protected var entities:Boolean = true;
		protected var includeRetweets:Boolean = true;
				
		
		/**
		 * 
		 * @param api              Required. The Twitter API client to run this loader against.
		 * 
		 * @param listId           Optional. Id of the list.
		 *  
		 * @param slug             Optional. The slug of the list. If specified, the ownerId or ownerScreenName is required.
		 * 
		 * @param ownerScreenName  Optional. The list owner's screen name. This or ownerId is required if using slug.
		 * 
		 * @param ownerId          Optional. The list owner's id. This or ownerScreenName is required if using slug.
		 * 
		 * 						     Example: since_id=12345
		 * @param maxId			   Optional. Returns only statuses with an ID less than (that is, older than) 
		 * 						     or equal to the specified ID. 
		 * 						     Example: max_id=54321
		 * 
		 * @param perPage		   Optional. Specifies the number of statuses to retrieve. May not be greater than 200.  
		 * 						     Example: per_page=5 
		 * 
		 * @param entities         Optional. Whether or not to include status entities.
		 * 
		 * @param includeRetweets  Optional. Whether or not to include Retweets.
		 * 
		 */
		public function ListStatusesLoader(api:TwitterAPI, 
										   listId:String, slug:String = null, ownerScreenName:String = null, ownerId:String = null,
										   maxId:String=null, perPage:int=-1, entities:Boolean = true, includeRetweets:Boolean = true,
										   postType:String=TwitterAPI.POST_TYPE_NORMAL, priority:int=TwitterAPI.PRIORITY_NORMAL)
		{
			super(api, LoadListStatuses, postType, priority);
			this.listId = listId;
			this.slug = slug;
			this.ownerScreenName = ownerScreenName;
			this.ownerId = ownerId;
			this.maxId = maxId;
			this.perPage = perPage;
			this.entities = entities;
			this.includeRetweets = includeRetweets;
			
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
			return new LoadListStatuses(listId, slug, ownerScreenName, ownerId, sinceId, maxId, perPage, entities, includeRetweets)
		}
	}
}
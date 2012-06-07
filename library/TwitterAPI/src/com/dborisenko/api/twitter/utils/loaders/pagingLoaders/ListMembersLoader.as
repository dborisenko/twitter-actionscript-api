/** ListMembersLoader.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2010.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.utils.loaders.pagingLoaders
{
	import com.dborisenko.api.twitter.TwitterAPI;
	import com.dborisenko.api.twitter.commands.listMembers.LoadListMembers;
	import com.dborisenko.api.twitter.net.TwitterOperation;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * List Members Loader class. Loads all the pages of the list members.
	 * @author Denis Borisenko
	 * 
	 */
	public class ListMembersLoader extends PagingLoader
	{
		protected var listId:String;
		protected var slug:String;
		protected var ownerScreenName:String;
		protected var ownerId:String;
		protected var entities:Boolean = true;
		protected var skipStatus:Boolean = false;
		
		/**
		 * @param API                       Required. The Twitter API to run command against.
		 * 
		 * @param listId					Optional. The id or slug of the list.
		 * 
		 * @param slug                      Optional. The slug of the list. If used, ownerScreenName or ownerId is required.
		 * 
		 * @param ownerScreenName           Optional. The screen name of the owner.
		 * 
		 * @param ownerId                   Optional. The id of the owner.
		 * 
		 * @param entities                  Optional. Include entities in the user tweets.
		 * 
		 * @param skipStatus                Optional. Skip the status in returned users.
		 * 
		 */
		public function ListMembersLoader(api:TwitterAPI,
										  listId:String = null, slug:String = null, ownerScreenName:String = null, ownerId:String = null,
										  entities:Boolean = true, skipStatus:Boolean = false,
										  postType:String=TwitterAPI.POST_TYPE_NORMAL, 
										  priority:int=TwitterAPI.PRIORITY_NORMAL, list:ArrayCollection=null)
		{
			super(api, LoadListMembers, postType, priority, list);
			this.listId = listId;
			this.slug = slug;
			this.ownerScreenName = ownerScreenName;
			this.ownerId = ownerId;
			this.entities = entities;
			this.skipStatus = skipStatus;
		}
		
		override protected function createOperation() : TwitterOperation
		{
			return new LoadListMembers(listId, slug, ownerScreenName, ownerId, '-1', entities, skipStatus);
		}
	}
}
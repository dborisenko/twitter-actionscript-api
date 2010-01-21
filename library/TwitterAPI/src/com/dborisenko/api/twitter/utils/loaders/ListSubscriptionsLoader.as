/** ListSubscriptionsLoader.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2010.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.utils.loaders
{
	import com.dborisenko.api.twitter.TwitterAPI;
	import com.dborisenko.api.twitter.commands.list.LoadListSubscriptions;
	import com.dborisenko.api.twitter.net.TwitterOperation;
	
	import mx.collections.ArrayCollection;
	
	public class ListSubscriptionsLoader extends PagingLoader
	{
		protected var user:String;
		
		public function ListSubscriptionsLoader(api:TwitterAPI, 
												user:String,
												postType:String=TwitterAPI.POST_TYPE_NORMAL, 
												priority:int=TwitterAPI.PRIORITY_NORMAL, list:ArrayCollection=null)
		{
			super(api, LoadListSubscriptions, postType, priority, list);
			this.user = user;
		}
		
		override protected function createOperation() : TwitterOperation
		{
			return new LoadListSubscriptions(user);
		}
	}
}
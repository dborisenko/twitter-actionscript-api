/** ListMembersLoader.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2010.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.utils.loaders
{
	import com.dborisenko.api.twitter.TwitterAPI;
	import com.dborisenko.api.twitter.commands.listMembers.LoadListMembers;
	
	import mx.collections.ArrayCollection;
	
	public class ListMembersLoader extends PagingLoader
	{
		public function ListMembersLoader(api:TwitterAPI, postType:String=TwitterAPI.POST_TYPE_NORMAL, 
										  priority:int=TwitterAPI.PRIORITY_NORMAL, list:ArrayCollection=null)
		{
			super(api, LoadListMembers, postType, priority, list);
		}
	}
}
/** ListsOperation.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.net
{
	import com.dborisenko.api.twitter.data.TwitterList;
	import com.dborisenko.api.twitter.data.collections.ListsCollection;
	
	import flash.events.Event;

	/**
	 * 
	 * Base operation for work with Collection of Twitter Lists
	 * @author Denis Borisenko
	 * 
	 */
	public class ListsOperation extends TwitterOperation
	{
		public function ListsOperation(url:String, requiresAuthentication:Boolean=true, params:Object=null)
		{
			super(url, requiresAuthentication, params, resultFormat);
		}
		
		/**
		 * 
		 * Collection of the Twitter Lists, received by the operation. 
		 * 
		 */
		[Bindable]
		public function set lists(value:ListsCollection):void
		{
			data = value;
		}
		public function get lists():ListsCollection
		{
			return data as ListsCollection;
		}
		
		/**
		 * 
		 * @private
		 * 
		 */
		override protected function handleResult(event:Event) : void
		{
			
			var json:Object = getJSON();
			
			if(json['lists']){
				lists = new ListsCollection();
				lists.nextCursor = json['next_cursor_str'];
				lists.previousCursor = json['previous_cursor_str'];
				
				for each (var item:Object in json['lists']){
					var list:TwitterList = new TwitterList(item);
					lists.addItem(list);
				}
			}
			
			super.handleResult(event);
		}
	}
}
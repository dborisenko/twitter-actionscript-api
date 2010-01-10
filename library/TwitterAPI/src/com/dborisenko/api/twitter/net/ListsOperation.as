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

	public class ListsOperation extends TwitterOperation
	{
		public function ListsOperation(url:String, requiresAuthentication:Boolean=true, params:Object=null)
		{
			super(url, requiresAuthentication, params, resultFormat);
		}
		
		[Bindable]
		public function set lists(value:ListsCollection):void
		{
			data = value;
		}
		
		public function get lists():ListsCollection
		{
			return data as ListsCollection;
		}
		
		override protected function handleResult(event:Event) : void
		{
			var xml:XML = getXML();
			if (xml.name() == "lists_list")
			{
				lists = new ListsCollection();
				lists.nextCursor = xml.next_cursor.toString();
				lists.previousCursor = xml.previous_cursor.toString();
				
				for each (var item:XML in xml.lists.list)
				{
					var list:TwitterList = new TwitterList(item);
					lists.addItem(list);
				}
			}
			super.handleResult(event);
		}
	}
}
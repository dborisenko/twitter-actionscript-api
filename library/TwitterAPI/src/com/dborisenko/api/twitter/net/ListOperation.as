/** ListOperation.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.net
{
	import com.dborisenko.api.twitter.data.TwitterList;
	
	import flash.events.Event;

	/**
	 * 
	 * Base operation for work with Twitter List
	 * @author Denis Borisenko
	 * 
	 */
	public class ListOperation extends TwitterOperation
	{
		public function ListOperation(url:String, requiresAuthentication:Boolean=true, 
										params:Object=null)
		{
			super(url, requiresAuthentication, params);
		}
		
		/**
		 * 
		 * Twitter List, received by the operation. 
		 * 
		 */
		[Bindable]
		public function get list():TwitterList
		{
			return data as TwitterList;
		}
		public function set list(value:TwitterList):void
		{
			data = value;
		}
		
		/**
		 * 
		 * @private
		 * 
		 */
		override protected function handleResult(event:Event) : void
		{
			var xml:XML = getXML();
			if (xml.name() == "list")
			{
				list = new TwitterList(xml);
			}
			super.handleResult(event);
		}
	}
}
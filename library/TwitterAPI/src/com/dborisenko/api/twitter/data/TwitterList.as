/** TwitterList.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.data
{
	import com.dborisenko.api.vo.ValueObject;
	
	import mx.events.FlexEvent;

	[Bindable]
	[Event(name="dataChange", type="mx.events.FlexEvent")]
	public class TwitterList extends ValueObject
	{
		public static const MODE_PRIVATE:String = "private";
		public static const MODE_PUBLIC:String = "public";
		
		public var id:String;
		private var _name:String;
		public var fullName:String;
		public var slug:String;
		public var description:String;
		public var subscriberCount:int;
		public var memberCount:int;
		public var uri:String;
		public var mode:String = MODE_PUBLIC;
		public var user:TwitterUser;
		
		public function TwitterList(list:Object)
		{
			super();
			parseXML(list);
		}
		
		[Bindable("dataChange")]
		public function get name():String
		{
			return _name;
		}
		public function set name(value:String):void
		{
			if (_name == value)
				return;
			_name = value;
			dispatchDataChangeEvent();
		}

		public function parseXML(list:Object):void
		{
			if (!list)
				return;
			
			id = list.id;
			name = list.name;
			fullName = list.full_name;
			slug = list.slug;
			description = list.description;
			subscriberCount = int(list.subscriber_count);
			memberCount = int(list.member_count);
			uri = list.uri;
			mode = list.mode;
			user = new TwitterUser(list.user);
		}
		
		protected function dispatchDataChangeEvent():void
		{
			dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
		}
	}
}
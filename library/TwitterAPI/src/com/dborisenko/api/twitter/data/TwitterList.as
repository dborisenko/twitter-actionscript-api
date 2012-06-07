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
	/**
	 * Twitter List
	 * @author Denis Borisenko
	 * 
	 */
	public class TwitterList extends ValueObject
	{
		public static const MODE_PRIVATE:String = "private";
		public static const MODE_PUBLIC:String = "public";
		
		private var _name:String;
		
		public var createdAt:Date;
		public var id:String;
		public var fullName:String;
		public var slug:String;
		public var description:String;
		public var subscriberCount:int;
		public var memberCount:int;
		public var uri:String;
		public var mode:String = MODE_PUBLIC;
		public var user:TwitterUser;
		public var following:Boolean = false;
		
		
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

		
		public function TwitterList(list:Object, isXML:Boolean = false)
		{
			super();
			if(isXML){
				parseXML(list);
			}else{
				parseJSON(list)
			}
		}
		
		
		public function parseJSON(json:Object):void{
			this.createdAt = new Date(Date.parse(json['created_at']));
			this.slug = json['slug'];
			this.name = json['name'];
			this.fullName = json['full_name'];
			this.description = json['description'];
			this.mode = json['mode'];
			this.following = json['following'];
			this.memberCount = json['member_count'];
			this.id = json['id_str'];
			this.subscriberCount = json['subscriber_count'];
			this.uri = json['uri'];
			this.user = new TwitterUser(json['user']);
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
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

	public class TwitterList extends ValueObject
	{
		public static const MODE_PRIVATE:String = "private";
		public static const MODE_PUBLIC:String = "public";
		
		public var id:String;
		public var name:String;
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
	}
}
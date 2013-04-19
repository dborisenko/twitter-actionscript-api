package com.dborisenko.api.twitter.data
{
	public class StreamingObject
	{
		
		public static const TYPE_STATUS:String = "twitterStatus";
		public static const TYPE_DELETE:String = "delete";
		public static const TYPE_SCRUB_GEO:String = "scrubGeo";
		public static const TYPE_LIMIT:String = "limit";
		public static const TYPE_STATUS_WITHHELD:String = "statusWithheld";
		public static const TYPE_USER_WITHHELD:String = "userWithheld";
		public static const TYPE_FRIENDS:String = "friends";
		public static const TYPE_EVENT:String = "event";
		public static const TYPE_CONTROL:String = "control";
		public static const TYPE_MESSAGE:String = "message";
		public static const TYPE_EMPTY:String = "empty";
		public static const TYPE_UNKNOWN:String = "unknown";
		
		
		public var data:Object;
		public var type:String = TYPE_EMPTY;
		
		public function StreamingObject(data:Object, type:String)
		{
			this.data = data;
			this.type = type;
		}
	}
}
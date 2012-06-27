package com.dborisenko.api.twitter.events
{
	import com.dborisenko.api.twitter.data.StreamingObject;

	public class TwitterStreamingEvent extends TwitterEvent
	{
		
		public static const PROGRESS:String = "progress";
		public static const STREAM_ERROR:String = "streamError";
		
		public var streamObject:StreamingObject;
		
		public function TwitterStreamingEvent(type:String, streamObject:StreamingObject = null, 
											  success:Boolean=false, info:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.streamObject = streamObject;
			super(type, info, success, bubbles, cancelable);
		}
	}
}
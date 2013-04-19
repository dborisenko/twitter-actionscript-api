package com.dborisenko.api.twitter.data
{
	import com.dborisenko.api.twitter.commands.streaming.StreamingParser;

	public class StreamingMessage
	{
		
		public var forUserId:String;
		public var message:StreamingObject;
		
		
		/**
		 * Site Streams are sent the same messages as User Streams (including friends lists in the preamble), 
		 * but for multiple users instead of a single user. The same types of messages are streamed, but to 
		 * identify the target of each message, an additional wrapper is placed around every message, except 
		 * for blank keep-alive lines. The Site Streams messages for two friends lists would look like:
		 **/
		public function StreamingMessage(data:Object = null)
		{
			if(data)
				parseData(data);
		}
		
		/**
		 * {
			  "for_user":"1888",
			  "message":{"friends":[]}
			}
			{
			  "for_user":"9160152",
			  "message":{"friends":[]}
			}
		 **/
		public function parseData(data:Object):void
		{
			var parser:StreamingParser = new StreamingParser();
			if(data['for_user'] == null){
				return;
			}
			
			this.forUserId = data['for_user'].toString();
			this.message = parser.parseData(data['message']);
			
		}
	}
}
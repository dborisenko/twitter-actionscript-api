package com.dborisenko.api.twitter.data
{
	public class StreamingLimit
	{
		
		public var track:Number;
		
		/**
		 * These messages indicate that a filtered stream has matched more Tweets than its 
		 * current rate limit allows to be delivered. Limit notices contain a total count of the 
		 * number of undelivered Tweets since the connection was opened, making them useful for 
		 * tracking counts of track terms, for example. Note that the counts do not specify which 
		 * filter predicates undelivered messages matched.
		 **/
		public function StreamingLimit(data:Object = null)
		{
			if(data)
				parseData(data);
		}
		
		/**
		 * {
		  "limit":{
			    "track":1234
			  }
			}
		 **/
		public function parseData(data:Object):void
		{
			if(data['limit'] == null){
				return;
			}
			
			this.track = data['limit']['track'];
			
		}
	}
}
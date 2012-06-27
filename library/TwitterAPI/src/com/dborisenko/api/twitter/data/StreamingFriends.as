package com.dborisenko.api.twitter.data
{
	public class StreamingFriends
	{
		
		public var ids:Array;
		
		/**
		 * Upon establishing a User Stream connection, Twitter will send a preamble before starting regular message delivery. 
		 * This preamble contains a list of the user’s friends. This is represented as an array of user ids, for example:
		 **/
		public function StreamingFriends(data:Object = null)
		{
			if(data)
				parseData(data);
		}
		
		/**
		 *{
			  "friends":[
			    1497,
			    169686021,
			    790205,
			    15211564,
			    ...
			  ]
			} 
		 **/
		public function parseData(data:Object):void
		{
			if(data['friends'] == null){
				return
			}
			
			this.ids = data['friends'];
		}
	}
}
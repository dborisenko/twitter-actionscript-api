package com.dborisenko.api.twitter.data
{
	public class StreamingDelete
	{
		
		public var statusId:String;
		public var userId:String;
		
		/**
		 * These messages indicate that a given Tweet has been deleted. Client code must honor these messages
		 * by clearing the referenced Tweet from memory and any storage or archive, even in the rare case where 
		 * a deletion message arrives earlier in the stream that the Tweet it references.
		 **/
		public function StreamingDelete(data:Object = null)
		{
			if(data)
				parseData(data);
		}
		
		
		
		
		/**
		 * {
		 "delete":{
			 "status":{
			 "id":1234,
			 "id_str":"1234",
			 "user_id":3,
			 "user_id_str":"3"
			 }
		 	}
		 }
		 **/
		public function parseData(data:Object):void
		{
			if((data['delete'] == null) || (data['delete']['status'] == null)){
				return
			}
			
			this.statusId = data['delete']['status']['id_str'];
			this.userId = data['delete']['status']['user_id_str'];
			
		}
	}
}
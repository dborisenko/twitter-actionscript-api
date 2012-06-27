package com.dborisenko.api.twitter.data
{
	public class StreamingScrubGeo
	{
		
		public var userId:String;
		public var upToStatusId:String;
		
		/**
		 *These messages indicate that geolocated data must be stripped from a range of Tweets. 
		 * Clients must honor these messages by deleting geocoded data from Tweets which fall before 
		 * the given status ID and belong to the specified user. These messages may also arrive before a 
		 * Tweet which falls into the specified range, although this is rare. 
		 **/
		public function StreamingScrubGeo(data:Object = null)
		{
			if(data)
				parseData(data);
		}
		
		/**
		 * {
			  "scrub_geo":{
			    "user_id":14090452,
			    "user_id_str":"14090452",
			    "up_to_status_id":23260136625,
			    "up_to_status_id_str":"23260136625"
			  }
			}
		 **/
		public function parseData(data:Object):void
		{
			if(data['scrub_geo'] == null){
				return
			}
			
			this.userId = data['scrub_geo']['user_id_str'];
			this.upToStatusId = data['scrub_geo']['up_to_status_id_str'];
		}
	}
}
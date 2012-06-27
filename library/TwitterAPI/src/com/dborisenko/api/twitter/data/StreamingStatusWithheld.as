package com.dborisenko.api.twitter.data
{
	public class StreamingStatusWithheld
	{
		
		public var statusId:String;
		public var userId:String;
		public var withheldInCountries:Array;
		
		/**
		 * These events contain an id field indicating the status ID, a user_id indicating the user, 
		 * and a collection of withheld_in_countries two-letter country codes. This example illustrates 
		 * a hypothetical tweet that has been withheld in Germany and Argentina.
		 **/
		public function StreamingStatusWithheld(data:Object = null)
		{
			if(data)
				parseData(data);
		}
		
		/**
		 * {
			  "status_withheld":{
			      "id":1234567890,
			      "user_id":123456,
			      "withheld_in_countries":["de", "ar"]
			  }
			}
		 **/
		public function parseData(data:Object):void
		{
			if(data['status_withheld'] == null){
				return;
			}
			
			this.statusId = data['status_withheld']['id'].toString();
			this.userId = data['status_withheld']['user_id'].toString();
			this.withheldInCountries = data['status_withheld']['withheld_in_countries'];
		}
			
	}
}
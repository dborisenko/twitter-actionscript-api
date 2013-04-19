package com.dborisenko.api.twitter.data
{
	public class StreamingUserWithheld
	{
		
		public var userId:String;
		public var withheldInCountries:Array;
		/**
		 * These events contain an id field indicating the user ID and a collection of withheld_in_countries 
		 * two-letter country codes. This example illustrates a hypothetical user who has been withheld in 
		 * Germany and Argentina.
		 **/
		public function StreamingUserWithheld(data:Object = null)
		{
			if(data)
				parseData(data);
		}
		
		/**
		 * {  
			  "user_withheld":{
			    "id":123456,
			    "withheld_in_countries":["de","ar"]
			  }
			}
		 **/
		public function parseData(data:Object):void
		{
			if(data['user_withheld'] == null)
			{
				return;
			}
			
			this.userId = data['user_withheld']['id'].toString();
			this.withheldInCountries = data['user_withheld']['withheld_in_countries'];
			
		}
	}
}
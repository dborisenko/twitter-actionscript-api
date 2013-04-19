package com.dborisenko.api.twitter.data
{
	public class TwitterPlace
	{
		public var rawData:Object;
		public var name:String;
		public var countryCode:String;
		public var country:String;
		public var attributes:Object;
		public var url:String;
		public var id:String;
		public var boundingBox:Object;
		public var fullName:String;
		public var type:String;
		
		
		public function TwitterPlace(data:Object = null)
		{
			if(data){
				parseJSON(data);
				this.rawData = data;
			}
		}
		
		public function parseJSON(data:Object):void{
			
			name = data['name'];
			countryCode = data['country_code'];
			country = data['country'];
			attributes = data['attributes'];
			url = data['url'];
			id = data['id'];
			boundingBox = data['bounding_box']; // contains coords and types. Not sure what's available here. Docs are laaaame.
			fullName = data['full_name'];
			type = data['place_type'];
			
		}
	}
}
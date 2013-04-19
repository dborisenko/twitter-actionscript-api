package com.dborisenko.api.twitter.data
{
	public class TwitterEntity
	{
		//as far as I can tell these are the only three types of entities so far.
		public static const ENTITY_TYPE_URL:String = "url";
		public static const ENTITY_TYPE_HASHTAG:String = "hashtag";
		public static const ENTITY_TYPE_MENTION:String = "usermention";
		public static const ENTITY_TYPE_MEDIA:String = "media";
		
		
		public var rawData:Object;
		public var type:String;
		//url specific
		public var expandedURL:String;
		public var url:String;
		public var displayURL:String;
		//hashtag
		public var hashText:String;
		//user
		public var name:String;
		public var mentionId:String; // int also available.
		public var screenName:String;
		//media
		public var mediaId:String;
		public var mediaURL:String;
		public var mediaURLHttps:String;
		public var mediaSizes:Object;
		public var mediaType:String;
		// general
		public var indices:Array;
		//derived
		public var startIndex:int;
		public var endIndex:int;
		
		
		
		public function TwitterEntity():void{
			
		}
		
		public function parseJSON(data:Object, type:String):void{
		
			if((type == TwitterEntity.ENTITY_TYPE_URL) || (type == TwitterEntity.ENTITY_TYPE_MEDIA)){
				expandedURL = data['expanded_url'];
				url = data['url'];
				displayURL = data['display_url'];
			}else if(type == TwitterEntity.ENTITY_TYPE_HASHTAG){
				hashText = data['text'];
			}else if(type == TwitterEntity.ENTITY_TYPE_MENTION){
				name = data['name'];
				mentionId = data['id'];
				screenName = data['screen_name'];
			}
			
			if(type == TwitterEntity.ENTITY_TYPE_MEDIA){
				mediaId = data['id_str'];
				mediaURL = data['media_url'];
				mediaURLHttps = data['media_url_https'];
				mediaSizes = data['sizes'];
				mediaType = data['type'];
			}
			
			indices = data['indices'];
			startIndex = indices[0];
			endIndex = indices[1];
			this.type = type;
			
			
		}
		
	
	}
}
/** TwitterStatus.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.data
{
	import com.dborisenko.api.vo.ValueObject;
	import com.hurlant.crypto.symmetric.NullPad;

	[Bindable]
	/**
	 * Twitter Status
	 * @author Denis Borisenko
	 * 
	 */
	public class TwitterStatus extends ValueObject
	{
		public var createdAt:Date;
		public var id:String;
		public var text:String;
		public var source:String;
		public var truncated:Boolean;
		public var inReplyToStatusId:String;
		public var inReplyToUserId:String;
		public var favorited:Boolean;
		public var inReplyToScreenName:String;
		public var user:TwitterUser;
		
		//Added by CS
		public var geo:Object = null; //Our JSON renders as: "geo": { "type":"Point", "coordinates":[37.78029, -122.39697] }
		public var coordinates:Object = null; //not defined in the API
		public var place:TwitterPlace = null; //API needs better documentation.
		public var contributors:Array = null;
		public var retweeted:Boolean = false;
		public var retweetCount:int = 0;
		public var possiblySensitive:Boolean = false;
		public var urls:Vector.<TwitterEntity> = null;
		public var hashtags:Vector.<TwitterEntity> = null;
		public var userMentions:Vector.<TwitterEntity> = null;
		public var entities:Vector.<TwitterEntity> = null; // This would be a collection of the 3 above.
		public var annotations:Object = null; // no idea what this is.
		//search
		public var resultType:String;
		
		
		public var isMention:Boolean = false;
		
		public var retweetedStatus:TwitterStatus;
		
		public function TwitterStatus(status:Object, twitterUser:TwitterUser = null, isXML:Boolean = false, isSearch:Boolean = false)
		{
			if (isXML)
			{
				parseXML(status);
				if (twitterUser)
				{
					this.user = twitterUser;
				} 
				else if (status.user != null) 
				{
					this.user = new TwitterUser(status.user);
				}
			}
			else
			{
				if(isSearch){
					parseSearchJSON(status);
					this.user = new TwitterUser(status, false, true);	//status, isXml, isSearch
				}else{
					parseJSON(status);
				}
			}
		}
		
		public function parseXML(status:Object):void
		{
			this.createdAt = new Date(Date.parse(status.created_at.toString()));//CreatedAtDate.parse(status.created_at);
			this.id = status.id;
			this.text = status.text;
			this.source = status.source;
			this.truncated = ((status.truncated != null && status.truncated.toString() == "true") ? true : false);
			this.inReplyToStatusId = status.in_reply_to_status_id;
			this.inReplyToUserId = status.in_reply_to_user_id;
			this.favorited = ((status.favorited != null && status.favorited.toString() == "true") ? true : false);
			this.inReplyToScreenName = status.in_reply_to_screen_name;
			if (status.retweeted_status != null && status.retweeted_status.toString() != "")
			{
				this.retweetedStatus = new TwitterStatus(status.retweeted_status);
			}
		}
		
		public function parseJSON(status:Object):void
		{
			this.coordinates = status['coordinates'];
			this.favorited = status['favorited'];
			this.createdAt = new Date(Date.parse(status['created_at'].toString()));//CreatedAtDate.parse(status.created_at);
			this.truncated = status['truncated'];
			this.text = status['text'];
			this.annotations = status['annotations'];
			this.contributors = status['contributors'];
			this.id = status['id_str'] == null ? status['id'].toString() : status['id_str'];
			this.geo = status['geo']; // better parsing needed.
			this.inReplyToUserId = status['in_reply_to_user_id'];
			this.inReplyToScreenName = status['in_reply_to_screen_name'];
			this.place = status['place'] == null ? null : new TwitterPlace(status['place']); //places have names, urls, bounding boxes, etc.
			this.source = status['source'];
			this.inReplyToStatusId = status['in_reply_to_status_id'];
			this.retweeted = status['retweeted'];
			this.retweetCount = status['retweet_count'];
			this.possiblySensitive = status['possibly_sensitive'];
			
			if(status['retweeted_status']){
				this.retweetedStatus = new TwitterStatus(status['retweeted_status']);
			}
			
			if(status['entities']){
				var e:Object;
				//add URLs
				if(status['entities']['urls']){
					this.urls = new Vector.<TwitterEntity>();
					for each(e in status['entities']['urls']){
						var newURL:TwitterEntity = new TwitterEntity();
						newURL.parseJSON(e, TwitterEntity.ENTITY_TYPE_URL);
						this.urls.push(newURL);
					}
					
				}
				
				//add Hashtags
				if(status['entities']['hashtags']){
					this.hashtags = new Vector.<TwitterEntity>();
					for each(e in status['entities']['hashtags']){
						var newHash:TwitterEntity = new TwitterEntity();
						newHash.parseJSON(e, TwitterEntity.ENTITY_TYPE_HASHTAG);
						this.hashtags.push(newHash);
					}
				}
				
				//add mentions
				if(status['entities']['user_mentions']){
					this.userMentions = new Vector.<TwitterEntity>();
					for each(e in status['entities']['user_mentions']){
						var newMention:TwitterEntity = new TwitterEntity();
						newMention.parseJSON(e, TwitterEntity.ENTITY_TYPE_MENTION);
						this.userMentions.push(newMention);
					}	
				}
				
			}
			
			
		}
		
		public function parseSearchJSON(status:Object):void{
			
			this.createdAt = new Date(Date.parse(status['created_at'].toString()));//CreatedAtDate.parse(status.created_at);
			this.text = status['text'];
			this.id = status['id_str'] == null ? status['id'].toString() : status['id_str'];
			this.geo = status['geo']; // better parsing needed.
			this.inReplyToUserId = status['to_user_id_str'];
			this.source = status['source'];
			
			if(status['entities']){
				var e:Object;
				//add URLs
				if(status['entities']['urls']){
					this.urls = new Vector.<TwitterEntity>();
					for each(e in status['entities']['urls']){
						var newURL:TwitterEntity = new TwitterEntity();
						newURL.parseJSON(e, TwitterEntity.ENTITY_TYPE_URL);
						this.urls.push(newURL);
					}
					
				}
				
				//add Hashtags
				if(status['entities']['hashtags']){
					this.hashtags = new Vector.<TwitterEntity>();
					for each(e in status['entities']['hashtags']){
						var newHash:TwitterEntity = new TwitterEntity();
						newHash.parseJSON(e, TwitterEntity.ENTITY_TYPE_HASHTAG);
						this.hashtags.push(newHash);
					}
				}
				
				//add mentions
				if(status['entities']['user_mentions']){
					this.userMentions = new Vector.<TwitterEntity>();
					for each(e in status['entities']['user_mentions']){
						var newMention:TwitterEntity = new TwitterEntity();
						newMention.parseJSON(e, TwitterEntity.ENTITY_TYPE_MENTION);
						this.urls.push(newMention);
					}	
				}
				
			}
			
			if(status['metadata']){
				this.resultType = status['metadata']['result_type'];
			}
			
		}
		
		
	}
}
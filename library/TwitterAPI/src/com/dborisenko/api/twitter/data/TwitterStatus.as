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

	[Bindable]
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
		
		public var isMention:Boolean = false;
		
		public var retweetedStatus:TwitterStatus;
		
		public function TwitterStatus(status:Object, twitterUser:TwitterUser=null, isXML:Boolean=true)
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
				parseJSON(status);
				this.user = new TwitterUser(status, false);
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
			this.createdAt = new Date(Date.parse(status.created_at.toString()));//CreatedAtDate.parse(status.created_at);
			this.id = status.id;
			this.text = status.text;
			this.source = status.source;
//			this.truncated = ((status.truncated != null && status.truncated.toString() == "true") ? true : false);
//			this.inReplyToStatusId = status.in_reply_to_status_id;
//			this.inReplyToUserId = status.in_reply_to_user_id;
//			this.favorited = ((status.favorited != null && status.favorited.toString() == "true") ? true : false);
//			this.inReplyToScreenName = status.in_reply_to_screen_name;
		}
	}
}
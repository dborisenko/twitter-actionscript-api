/** TwitterDirectMessage.as
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
	public class TwitterDirectMessage extends ValueObject
	{
		public var createdAt:Date;
		public var id:String;
		public var text:String;
		public var senderId:String;
		public var recipientId:String;
		public var senderScreenName:String;
		public var recipientScreenName:String;
		public var sender:TwitterUser;
		public var recipient:TwitterUser;
		
		public var isSent:Boolean = false;
		
		public function TwitterDirectMessage(directMessage:Object)
		{
			super();
			
			createdAt = new Date(Date.parse(directMessage.created_at.toString()));//CreatedAtDate.parse(directMessage.created_at);
			id = directMessage.id;
			senderId = directMessage.sender_id;
			text = directMessage.text;
			recipientId = directMessage.recipient_id;
			senderScreenName = directMessage.sender_screen_name;
			recipientScreenName = directMessage.recipient_screen_name;
			sender = new TwitterUser(directMessage.sender);
			recipient = new TwitterUser(directMessage.recipient);
		}
		
	}
}
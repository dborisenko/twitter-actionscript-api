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
	/**
	 * Twitter Direct message
	 * @author Denis Borisenko
	 * 
	 */
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
		
		public function TwitterDirectMessage(directMessage:Object, isXML:Boolean = false)
		{
			super();
			
			if(isXML){
				parseXML(directMessage);
			}else{
				parseJSON(directMessage);
			}
		}
		
		public function parseJSON(dm:Object):void{
			createdAt = new Date(Date.parse(dm['created_at'].toString()));//CreatedAtDate.parse(directMessage.created_at);
			id = dm['id'];
			text = dm['text'];
			senderId = dm['sender_id'];
			recipientId = dm['recipient_id'];
			senderScreenName = dm['sender_screen_name'];
			recipientScreenName = dm['recipient_screen_name'];
			sender = new TwitterUser(dm['sender']);
			recipient = new TwitterUser(dm['recipient']);
		}
		
		public function parseXML(dm:Object):void{
			
			createdAt = new Date(Date.parse(dm.created_at.toString()));//CreatedAtDate.parse(directMessage.created_at);
			id = dm.id;
			senderId = dm.sender_id;
			text = dm.text;
			recipientId = dm.recipient_id;
			senderScreenName = dm.sender_screen_name;
			recipientScreenName = dm.recipient_screen_name;
			sender = new TwitterUser(dm.sender);
			recipient = new TwitterUser(dm.recipient);
		}
		
	}
}
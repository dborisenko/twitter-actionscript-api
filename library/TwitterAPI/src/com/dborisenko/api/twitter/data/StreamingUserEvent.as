package com.dborisenko.api.twitter.data
{

	public class StreamingUserEvent
	{
		
		public var targetUser:Object; // no indication in API docs if this is an ID or the user object.
		public var sourceUser:Object; // same as above. These maybe should be User objects. Or Strings.
		public var eventType:String;
		public var targetObject:Object; 
		public var createdAt:Date;
		
		
		/**
		 * Notifications about non-Tweet events are also sent over a user stream.
		 **/
		public function StreamingUserEvent(data:Object = null)
		{
			if(data)
				parseData(data);
		}
		
		/**
		 * {
			  "target": TARGET_USER,
			  "source": SOURCE_USER, 
			  "event":"EVENT_NAME",
			  "target_object": TARGET_OBJECT,
			  "created_at": "Sat Sep 4 16:10:54 +0000 2010"
			}
		 **/
		public function parseData(data:Object):void
		{
			if(data['event'] == null){
				return;
			}
			
			try{
				this.targetUser = new TwitterUser(data['target']);
			}catch(e:Error){
				this.targetUser = data['target'];
			}
			try{
				this.sourceUser = new TwitterUser(data['source']);
			}catch(e:Error){
				this.sourceUser = data['source'];
			}
			this.eventType = data['event'];
			this.targetObject = parseTargetObject(data['target_object']);
			this.createdAt = new Date(Date.parse(data['created_at'].toString()));
			
		}
		
		/**
		 * EVENT TYPES
		 * 
		 * Description							Event Name				Source				Target			Target Object
		 User blocks someone 				block 					Current user 		Blocked user 	Null
		 User removes a block 				unblock 				Current user 		Unblocked user 	Null
		 User favorites a Tweet 				favorite 				Current user 		Tweet author 	Tweet
		 User's Tweet is favorited 			favorite 				Favoriting user 	Current user 	Tweet
		 User unfavorites a Tweet 			unfavorite 				Current user 		Tweet author 	Tweet
		 User's Tweet is unfavorited 		unfavorite 				Unfavoriting user 	Current user 	Tweet
		 User follows someone 				follow 					Current user 		Followed user 	Null
		 User is followed 					follow 					Following user 		Current user 	Null
		 User creates a list 				list_created 			Current user 		Current user 	List
		 User deletes a list 				list_destroyed 			Current user 		Current user 	List
		 User edits a list 					list_updated 			Current user 		Current user 	List
		 User adds someone to a list 		list_member_added 		Current user 		Added user 		List
		 User is added to a list 			list_member_added 		Adding user 		Current user 	List
		 User removes someone from a list 	list_member_removed 	Current user 		Removed user 	List
		 User is removed from a list 		list_member_removed 	Removing user 		Current user 	List
		 User subscribes to a list 			list_user_subscribed 	Current user 		List owner 		List
		 User's list is subscribed to 		list_user_subscribed 	Subscribing user 	Current user 	List
		 User unsubscribes from a list 		list_user_unsubscribed 	Current user 		List owner 		List
		 User's list is unsubscribed from 	list_user_unsubscribed 	Unsubscribing user 	Current user 	List
		 User updates their profile 			user_update 			Current user 		Current user 	Null
		 * 
		 * 
		 * 
		 **/
		protected function parseTargetObject(data:Object):Object
		{
			if(this.eventType.indexOf("favorite") != -1){
				return new TwitterStatus(data);
			}
			
			if(this.eventType.indexOf("list") != -1){
				return new TwitterList(data);
			}
			
			return data;
			
		}
		
		
		
		
		
	}
}
package com.dborisenko.api.twitter.commands.streaming
{
	import com.dborisenko.api.twitter.data.StreamingControl;
	import com.dborisenko.api.twitter.data.StreamingDelete;
	import com.dborisenko.api.twitter.data.StreamingFriends;
	import com.dborisenko.api.twitter.data.StreamingLimit;
	import com.dborisenko.api.twitter.data.StreamingMessage;
	import com.dborisenko.api.twitter.data.StreamingObject;
	import com.dborisenko.api.twitter.data.StreamingScrubGeo;
	import com.dborisenko.api.twitter.data.StreamingStatusWithheld;
	import com.dborisenko.api.twitter.data.StreamingUserEvent;
	import com.dborisenko.api.twitter.data.StreamingUserWithheld;
	import com.dborisenko.api.twitter.data.TwitterStatus;

	public class StreamingParser
	{
		public function StreamingParser()
		{
				
		}
		
		/**
		 * This method should take a data object from the Twitter Streaming API and convert it into an approrpiate ActionScript Object.
		 * Some of these are ill-defined in the documentation, but most are easy to detect (until they add new ones at least).
		 * 
		 * Some of the different types are documented here: https://dev.twitter.com/docs/streaming-apis/messages 
		 * 
		 * @param data.    Required. An object that originated as a piece of JSON from the Twitter Streaming API.
		 **/ 
		public function parseData(data:Object):StreamingObject
		{
			//There's no rael instantly identifiable characteristic for the data parts (as in, they aren't all
			//encapsulated in a single property), so we have to look for certain properties and assume the content type.
			
			if( (data['text'] != null) && (data['user'] != null)){
				var status:TwitterStatus = new TwitterStatus(data);
				return new StreamingObject(status, StreamingObject.TYPE_STATUS);
			}
			
			
			if(data['delete']){
				var streamDelete:StreamingDelete = new StreamingDelete(data);
				return new StreamingObject(streamDelete, StreamingObject.TYPE_DELETE);
			}
			
			if(data['scrub_geo']){
				var scrubGeo:StreamingScrubGeo = new StreamingScrubGeo(data);
				return new StreamingObject(scrubGeo, StreamingObject.TYPE_SCRUB_GEO);
			}
			
			if(data['limit']){
				var limit:StreamingLimit = new StreamingLimit(data);
				return new StreamingObject(limit, StreamingObject.TYPE_LIMIT);
			}
			
			if(data['status_withheld']){
				var statusWithheld:StreamingStatusWithheld = new StreamingStatusWithheld(data);
				return new StreamingObject(statusWithheld, StreamingObject.TYPE_STATUS_WITHHELD);
			}
			
			if(data['user_withheld']){
				var userWithheld:StreamingUserWithheld = new StreamingUserWithheld(data);
				return new StreamingObject(userWithheld, StreamingObject.TYPE_USER_WITHHELD);
			}
			
			if(data['friends']){
				var friends:StreamingFriends = new StreamingFriends(data);
				return new StreamingObject(friends, StreamingObject.TYPE_FRIENDS);
			}
			
			if(data['event']){
				var event:StreamingUserEvent = new StreamingUserEvent(data);
				return new StreamingObject(event, StreamingObject.TYPE_EVENT);
			}
			
			if(data['control']){
				var control:StreamingControl = new StreamingControl(data);
				return new StreamingObject(control, StreamingObject.TYPE_CONTROL);
			}
			
			
			if(data['for_user']){
				var message:StreamingMessage = new StreamingMessage(data);
				return new StreamingObject(message, StreamingObject.TYPE_MESSAGE);
			}
			
			
			return new StreamingObject(data, StreamingObject.TYPE_UNKNOWN);
		}
		
	}
}



package com.dborisenko.api.twitter.commands.streaming
{
	import com.dborisenko.api.twitter.net.TwitterStreamingOperation;
	
	public class UserStream extends TwitterStreamingOperation
	{
		/**
		 * This loads a stream of the user's content. Unlike the normal REST API this is done via a URLStream socket that continuously returns data as
		 * it is received. 
		 * 
		 * Details here: https://dev.twitter.com/docs/api/2/get/user
		 **/
		
		protected static const URL:String = "https://userstream.twitter.com/2/user.json";
		
		/**
		 * 
		 * /2/user.json?replies=all&stall_warnings=true&with=followings&delimited=false
		 * 
		 * @param delimited             optional. Specifies whether messages should be length-delimited. 
		 * 								 See the delimited parameter documentation for more information. values: "length", null
		 * 
		 * @param stallWarnings         optional Specifies whether stall warnings should be delivered.
		 * 
		 * @param withType 				optional. Specifies whether to return information for just the authenticating user, 
		 * 								  or include messages from accounts the user follows. values: "followings" or "user"
		 * 
		 * @param replies 				optional. Specifies whether to return additional @replies. values: "all" or null. 
		 * 
		 * @param follow 				optional. Includes additional public Tweets from the supplied array of user IDs.
		 * 
		 * @param track 				optional. Includes additional Tweets matching the specified keywords in an array. 
		 * 									Phrases of keywords are specified by a comma-separated list.
		 * @param locations 			optional. Includes additional Tweets falling within the specified bounding boxes.
		 * 									This needs improvement.
		 * 
		 * More on Parameters: https://dev.twitter.com/docs/streaming-apis/parameters
		 **/
		public function UserStream(delimited:String = null, stallWarnings:Boolean = true, withType:String = "followings",
									 replies:String = "all", follow:Array = null, track:Array = null, locations:String = null)
		{
			super(URL);
			this.method = METHOD_GET;
			this._requiresAuthentication = true;
			this._apiRateLimited = true;
			
			var followIds:String = null;
			var trackWords:String = null;
			if(follow != null){
				followIds = follow.join(",");
			}
			
			if(track != null){
				trackWords = track.join(",");
			}
			
			this.parameters = {'delimited': delimited, 'stall_warnings':stallWarnings, 'with':withType, 'replies':replies,
								'follow':followIds, 'track': trackWords, 'locations':locations};
			
		}
	}
}
/** LoadHomeTimeline.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.timeline
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.net.StatusesOperation;
	
	/**
	 * Returns the 20 most recent statuses, including retweets, posted by the authenticating user and that 
	 * user's friends. This is the equivalent of /timeline/home on the Web.
	 * Usage note: This home_timeline is identical to statuses/friends_timeline except it also contains retweets, 
	 * which statuses/friends_timeline does not (for backwards compatibility reasons). 
	 * In a future version of the API, statuses/friends_timeline will go away and be replaced by home_timeline.
	 * 
	 * @author Denis Borisenko
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-statuses-home_timeline
	 */
	public class LoadHomeTimeline extends StatusesOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "https://api.twitter.com/1/statuses/home_timeline.json";
		
		/**
		 * 
		 * @param sinceId		       Optional.  Returns only statuses with an ID greater than (that is, more recent than) 
		 * 						       the specified ID.  
		 * 						       Example: since_id=12345
		 * 
		 * @param maxId			       Optional.  Returns only statuses with an ID less than (that is, older than) 
		 * 						       or equal to the specified ID.
		 * 						       Example: max_id=54321
		 * 
		 * @param count			       Optional.  Specifies the number of statuses to retrieve. May not be greater than 200.
		 * 						       Example: count=5 
		 * 
		 * @param entities             Optional. Includes the entities array for things like URLs. 
		 *                             Example: true
		 * 
		 * @param includeRetweets      Optional. Includes native retweets within the response.Using this will cause the Count parameter
		 *                               to receive up-to count tweets -- because the count parameter retrieves that many tweets before
		 *                               filtering out retweets and replies.
		 *                             Example: true
		 * 
		 * @param excludeReplies       Optional. Excludes replies from appearing in the timeline. Using this will cause the Count parameter
		 *                               to receive up-to count tweets -- because the count parameter retrieves that many tweets before
		 *                               filtering out retweets and replies.
		 * 
		 * @see https://dev.twitter.com/docs/api/1/get/statuses/home_timeline
		 */
		public function LoadHomeTimeline(sinceId:String=null, maxId:String=null, count:int=-1,
										 entities:Boolean = true, includeRetweets:Boolean = true, excludeReplies:Boolean = false)
		{
			super(URL);
			resultFormat = ResultFormat.JSON;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
			parameters = {since_id: sinceId, max_id: maxId, count: count, include_entities:entities, 
				include_rts:includeRetweets, exclude_replies:excludeReplies};
		}
	}
}
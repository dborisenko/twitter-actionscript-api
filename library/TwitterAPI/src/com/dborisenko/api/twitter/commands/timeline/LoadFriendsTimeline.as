/** LoadFriendsTimeline.as
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
	 * Returns the 20 most recent statuses posted by the authenticating user and that user's friends. 
	 * This is the equivalent of /timeline/home on the Web.
	 * Note: Retweets will not appear in the friends_timeline for backwards compatibility. 
	 * If you want retweets included use Twitter REST API Method: statuses home_timeline.
	 * 
	 * @author Denis Borisenko
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-statuses-friends_timeline
	 */
	public class LoadFriendsTimeline extends StatusesOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "http://twitter.com/statuses/friends_timeline.xml";
		
		/**
		 * 
		 * @param sinceId		Optional.  Returns only statuses with an ID greater than (that is, more recent than) 
		 * 						the specified ID.
		 * 						Example: since_id=12345
		 * @param maxId			Optional.  Returns only statuses with an ID less than (that is, older than) 
		 * 						or equal to the specified ID.
		 * 						Example: max_id=54321
		 * @param count			Optional.  Specifies the number of statuses to retrieve. May not be greater than 200. 
		 * 						(Note the the number of statuses returned may be smaller than the requested count as 
		 * 						retweets are stripped out of the result set for backwards compatibility.) 
		 * 						Example: max_id=54321
		 * @param page			Optional. Specifies the page of results to retrieve. Note: there are pagination limits.
		 * 						( http://apiwiki.twitter.com/Things-Every-Developer-Should-Know#6Therearepaginationlimits )
		 * 						Example: page=3
		 * 
		 * @see http://apiwiki.twitter.com/Things-Every-Developer-Should-Know#6Therearepaginationlimits
		 */
		public function LoadFriendsTimeline(sinceId:String=null, maxId:String=null, count:int=-1, page:int=-1)
		{
			super(URL);
			resultFormat = ResultFormat.XML;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
			parameters = {since_id: sinceId, max_id: maxId, count: count, page: page};
		}
	}
}
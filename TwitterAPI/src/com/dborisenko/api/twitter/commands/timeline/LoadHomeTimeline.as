/** LoadHomeTimeline.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.timeline
{
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
		protected static const URL:String = "http://api.twitter.com/1/statuses/home_timeline.xml";
		
		/**
		 * 
		 * @param sinceId		Optional.  Returns only statuses with an ID greater than (that is, more recent than) 
		 * 						the specified ID.  
		 * 						Example: since_id=12345
		 * @param maxId			Optional.  Returns only statuses with an ID less than (that is, older than) 
		 * 						or equal to the specified ID.
		 * 						Example: max_id=54321
		 * @param count			Optional.  Specifies the number of statuses to retrieve. May not be greater than 200.
		 * 						Example: count=5 
		 * @param page			Optional. Specifies the page of results to retrieve. Note: there are pagination limits.
		 * 						( http://apiwiki.twitter.com/Things-Every-Developer-Should-Know#6Therearepaginationlimits )
		 * 						Example: page=3
		 * 
		 * @see http://apiwiki.twitter.com/Things-Every-Developer-Should-Know#6Therearepaginationlimits
		 */
		public function LoadHomeTimeline(sinceId:String=null, maxId:String=null, count:int=-1, page:int=-1)
		{
			super(URL);
			resultFormat = RESULT_FORMAT_XML;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
			parameters = {since_id: sinceId, max_id: maxId, count: count, page: page};
		}
	}
}
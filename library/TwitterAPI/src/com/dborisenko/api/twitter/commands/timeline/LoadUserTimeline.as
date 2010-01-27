/** LoadUserTimeline.as
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
	 * Returns the 20 most recent statuses posted from the authenticating user. It's also possible to request 
	 * another user's timeline via the id parameter. This is the equivalent of the Web /<user> page for your own 
	 * user, or the profile page for a third party.
	 * Note: For backwards compatibility reasons, retweets are stripped out of the user_timeline. If you'd like 
	 * them included, you can merge them in from statuses retweeted_by_me.
	 * 
	 * @author Denis Borisenko
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-statuses-user_timeline
	 */
	public class LoadUserTimeline extends StatusesOperation
	{
		protected static const URL:String = "http://twitter.com/statuses/user_timeline.xml";
		
		/**
		 * 
		 * @param id			Optional.  Specifies the ID or screen name of the user for whom to return the 
		 * 						user_timeline.
		 * 						Example: 12345 or bob
		 * @param userId		Optional.  Specfies the ID of the user for whom to return the user_timeline. 
		 * 						Helpful for disambiguating when a valid user ID is also a valid screen name.
		 * 						Example: user_id=1401881
		 * @param screenName	Optional.  Specfies the screen name of the user for whom to return the 
		 * 						user_timeline. Helpful for disambiguating when a valid screen name is also a user ID.
		 * 						Example: screen_name=101010 
		 * @param sinceId		Optional.  Returns only statuses with an ID greater than (that is, more recent than) 
		 * 						the specified ID.
		 * 						Example: since_id=12345  
		 * @param maxId			Returns only statuses with an ID less than (that is, older than) or equal to 
		 * 						the specified ID.
		 * 						Example: max_id=54321 
		 * @param count			Optional.  Specifies the number of statuses to retrieve. May not be greater than 200. 
		 * 						(Note the the number of statuses returned may be smaller than the requested count 
		 * 						as retweets are stripped out of the result set for backwards compatibility.)
		 * 						Example: count=200 
		 * @param page			Optional. Specifies the page of results to retrieve. Note: there are pagination limits. 
		 * 						( http://apiwiki.twitter.com/Things-Every-Developer-Should-Know#6Therearepaginationlimits )
		 * 						Example: page=3
		 * 
		 */
		public function LoadUserTimeline(id:String, userId:String=null, screenName:String=null, sinceId:String=null, 
										 maxId:String=null, count:int=-1, page:int=-1)
		{
			super(URL);
			resultFormat = ResultFormat.XML;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
			parameters = {id: id, user_id: userId, screen_name: screenName, since_id: sinceId,
				max_id: maxId, count: count, page: page};
		}
	}
}
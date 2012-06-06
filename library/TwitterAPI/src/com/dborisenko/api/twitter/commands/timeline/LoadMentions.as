/** LoadMentions.as
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
	 * Returns the 20 most recent mentions (status containing @username) for the authenticating user.
	 * 
	 * @author Denis Borisenko
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-statuses-mentions
	 */
	public class LoadMentions extends StatusesOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "http://api.twitter.com/1/statuses/mentions.json";
		
		/**
		 * 
		 * @param sinceId		       Optional.  Returns only statuses with an ID greater than (that is, more 
		 * 						         recent than) the specified ID. 
		 * 						       Example: since_id=12345
		 *
		 * @param maxId			       Optional.Returns only statuses with an ID less than (that is, older than) 
		 * 						         or equal to the specified ID.
		 * 						       Example: max_id=54321
		 * 
		 * @param count			       Optional.  Specifies the number of statuses to retrieve. May not be greater than 200.
		 * 						       Example: count=200
		 * 
		 * @param entities             Optional. Includes the entities array for things like URLs. 
		 *                             Example: true
		 * 
		 * @param includeRetweets      Optional. Includes native retweets within the response.Using this will cause the Count parameter
		 *                               to receive up-to count tweets -- because the count parameter retrieves that many tweets before
		 *                               filtering out retweets and replies.
		 *                             Example: true
		 * 
		 *  https://dev.twitter.com/docs/api/1/get/statuses/mentions
		 */
		public function LoadMentions(sinceId:String=null, maxId:String=null, count:int=-1, entities:Boolean = true, includeRetweets:Boolean = true)
		{
			super(URL, true, null, true);
			resultFormat = ResultFormat.JSON;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
			parameters = {since_id: sinceId, max_id: maxId, count: count, include_entities:entities, include_rts:includeRetweets};
		}
	}
}
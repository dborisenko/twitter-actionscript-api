/** LoadMentions.as
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
	 * Returns the 20 most recent mentions (status containing @username) for the authenticating user.
	 * 
	 * @author Denis Borisenko
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-statuses-mentions
	 */
	public class LoadMentions extends StatusesOperation
	{
		protected static const URL:String = "http://twitter.com/statuses/mentions.xml";
		
		/**
		 * 
		 * @param sinceId		Optional.  Returns only statuses with an ID greater than (that is, more 
		 * 						recent than) the specified ID. 
		 * 						Example: since_id=12345
		 * @param maxId			Optional.Returns only statuses with an ID less than (that is, older than) 
		 * 						or equal to the specified ID.
		 * 						Example: max_id=54321
		 * @param count			Optional.  Specifies the number of statuses to retrieve. May not be greater than 200.
		 * 						Example: count=200
		 * @param page			Optional. Specifies the page or results to retrieve. Note: there are pagination limits
		 * 						( http://apiwiki.twitter.com/Things-Every-Developer-Should-Know#6Therearepaginationlimits )
		 * 						Example: page=3
		 *  
		 */
		public function LoadMentions(sinceId:String=null, maxId:String=null, count:int=-1, page:int=-1)
		{
			super(URL, true, null, true);
			resultFormat = RESULT_FORMAT_XML;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
			parameters = {since_id: sinceId, max_id: maxId, count: count, page: page};
		}
	}
}
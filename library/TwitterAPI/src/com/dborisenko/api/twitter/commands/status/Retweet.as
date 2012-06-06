/** Retweet.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.status
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.net.StatusOperation;
	
	/**
	 * Retweets a tweet. Requires the id parameter of the tweet you are retweeting. Request must be a POST or PUT. 
	 * Returns the original tweet with retweet details embedded.
	 * 
	 * @author Denis Borisenko
	 * @see https://dev.twitter.com/docs/api/1/post/statuses/retweet/%3Aid
	 */
	public class Retweet extends StatusOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "http://api.twitter.com/1/statuses/retweet/{id}.json";
		
		/**
		 * 
		 * @param id		Required.  The numerical ID of the tweet you are retweeting. 
		 * 
		 */
		public function Retweet(id:String)
		{
			super(URL.replace(/\{id\}/gi, id));
			resultFormat = ResultFormat.JSON;
			method = METHOD_POST;
			_requiresAuthentication = true;
			_apiRateLimited = false;
			parameters = {id: id};
		}
	}
}
/** RateLimitStatus.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.account
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.data.TwitterRateLimit;
	import com.dborisenko.api.twitter.net.HashOperation;
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	/**
	 * Returns the remaining number of API requests available to the requesting user before the API limit is reached 
	 * for the current hour. Calls to rate_limit_status do not count against the rate limit.  If authentication 
	 * credentials are provided, the rate limit status for the authenticating user is returned.  Otherwise, the 
	 * rate limit status for the requester's IP address is returned. 
	 * Learn more about the REST API rate limiting here: 
	 * http://apiwiki.twitter.com/Rate-limiting 
	 * 
	 * @author Denis Borisenko
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-account%C2%A0rate_limit_status
	 * @see http://apiwiki.twitter.com/Rate-limiting
	 */
	public class RateLimitStatus extends HashOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "http://api.twitter.com/1/account/rate_limit_status.json";
		
		public function RateLimitStatus()
		{
			super(URL);
			resultFormat = ResultFormat.JSON;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = false;
		}
		
		public function get rateLimit():TwitterRateLimit
		{
			return data as TwitterRateLimit;
		}
		public function set rateLimit(value:TwitterRateLimit):void
		{
			data = value;
		}
		
		/**
		 * 
		 * @private
		 * 
		 */		
		override protected function handleResult(event:Event) : void
		{
			var json:Object = getJSON();
			rateLimit = new TwitterRateLimit(json);
			super.handleResult(event);
		}
	}
}
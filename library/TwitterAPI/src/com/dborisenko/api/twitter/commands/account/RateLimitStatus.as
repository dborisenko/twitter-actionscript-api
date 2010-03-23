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
		protected static const URL:String = "http://twitter.com/account/rate_limit_status.xml";
		
		public function RateLimitStatus()
		{
			super(URL);
			resultFormat = ResultFormat.XML;
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
			var hash:Dictionary = parseHash(getXML());
			rateLimit = new TwitterRateLimit(
				hash["remaining-hits"] as int, hash["hourly-limit"] as int, hash["reset-time-in-seconds"] as int
			);
			super.handleResult(event);
		}
	}
}
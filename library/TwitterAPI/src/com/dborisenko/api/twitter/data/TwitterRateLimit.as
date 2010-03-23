/** TwitterRateLimit.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.data
{
	import com.dborisenko.api.vo.ValueObject;

	/**
	 * Twitter Rate Limit
	 * @author Denis Borisenko
	 * 
	 */
	public class TwitterRateLimit extends ValueObject
	{
		public var remainingHits:int;
		public var hourlyLimit:int;
		public var resetTime:Date;
		
		public function TwitterRateLimit(remainingHits:int, hourlyLimit:int, resetTimeInSeconds:int)
		{
			super();
			this.remainingHits = remainingHits;
			this.hourlyLimit = hourlyLimit;
			this.resetTime = new Date(resetTimeInSeconds * 1000);
		}
	}
}
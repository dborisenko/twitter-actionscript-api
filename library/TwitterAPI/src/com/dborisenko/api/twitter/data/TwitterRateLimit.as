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
		public var resetTimeInSeconds:int;
		public var photoRemainingHits:int;
		public var photoResetTimeInSeconds:int;
		public var photoResetTime:Date;
		public var photoDailyLimit:int;
		
		public function TwitterRateLimit(json:Object = null)
		{
			super();
			if(json)
				parseJSON(json);
			
			//this.remainingHits = remainingHits;
			//this.hourlyLimit = hourlyLimit;
			//this.resetTime = new Date(resetTimeInSeconds * 1000);
		}
		
		public function parseJSON(json:Object):void{
			this.remainingHits = json['remaining_hits'];
			this.resetTimeInSeconds = json['remaining_time_in_seconds'];
			this.hourlyLimit = json['hourly_limit'];
			this.resetTime = new Date(Date.parse(json['reset_time'].toString()));
			//photos
			if(json['photos']){
				var p:Object = json['photos'];
				this.photoRemainingHits = p['remaining_hits'];
				this.photoResetTimeInSeconds = p['reset_time_in_seconds'];
				this.photoResetTime = new Date(Date.parse(p['reset_time'].toString()));
				this.photoDailyLimit = p['daily_limit'];
			}
			
			
		}
		
		
	}
}
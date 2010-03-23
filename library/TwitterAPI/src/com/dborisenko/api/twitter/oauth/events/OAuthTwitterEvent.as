/** OAuthTwitterEvent.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.oauth.events
{
	import flash.events.Event;

	/**
	 * Event of the OAuth authentication
	 * @author Denis Borisenko
	 * 
	 */
	public class OAuthTwitterEvent extends Event
	{
		/**
		 * Error of receiving request token.
		 */
		public static const REQUEST_TOKEN_ERROR:String = "requestTokenError";
		/**
		 * Request token received.
		 */		
		public static const REQUEST_TOKEN_RECEIVED:String = "requestTokenReceived";
		/**
		 * Error of receiving access token.
		 */
		public static const ACCESS_TOKEN_ERROR:String = "accessTokenError";
		/**
		 * Authentication successfully complete.
		 */
		public static const AUTHORIZED:String = "authorized";
		
		/**
		 * Data object of OAuth authentication event.
		 */		
		[Bindable]
		public var data:Object;
		
		public function OAuthTwitterEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
		
	}
}
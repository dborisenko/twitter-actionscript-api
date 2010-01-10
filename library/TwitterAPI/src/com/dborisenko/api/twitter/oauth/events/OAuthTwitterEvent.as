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

	public class OAuthTwitterEvent extends Event
	{
		public static const REQUEST_TOKEN_ERROR:String = "requestTokenError";
		public static const REQUEST_TOKEN_RECEIVED:String = "requestTokenReceived";
		public static const ACCESS_TOKEN_ERROR:String = "accessTokenError";
		public static const AUTHORIZED:String = "authorized";
		
		[Bindable]
		public var data:Object;
		
		public function OAuthTwitterEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
		
	}
}
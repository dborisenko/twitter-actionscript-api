/** UserOperation.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.net
{
	import com.dborisenko.api.twitter.data.TwitterUser;
	
	import flash.events.Event;
	
	/**
	 * 
	 * Base operation for work with Twitter User
	 * @author Denis Borisenko
	 * 
	 */
	public class UserOperation extends TwitterOperation
	{
		public function UserOperation(url:String, requiresAuthentication:Boolean=true, params:Object=null)
		{
			super(url, requiresAuthentication, params);
		}
		
		/**
		 * 
		 * Twitter User, received by the operation. 
		 * 
		 */
		[Bindable]
		public function set user(value:TwitterUser):void
		{
			data = value;
		}
		public function get user():TwitterUser
		{
			return data as TwitterUser;
		}
		
		/**
		 * 
		 * @private
		 * 
		 */
		override protected function handleResult(event:Event) : void
        {
			var json:Object = getJSON();
			user = new TwitterUser(json);
         	super.handleResult(event);
        }
	}
}
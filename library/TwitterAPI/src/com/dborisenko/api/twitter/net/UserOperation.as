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
	
	
	public class UserOperation extends TwitterOperation
	{
		public function UserOperation(url:String, requiresAuthentication:Boolean=true, params:Object=null)
		{
			super(url, requiresAuthentication, params);
		}
		
		[Bindable]
		public function set user(value:TwitterUser):void
		{
			data = value;
		}
		
		public function get user():TwitterUser
		{
			return data as TwitterUser;
		}
		
		override protected function handleResult(event:Event) : void
        {
			var xml:XML = getXML();
        	if (xml.name() == "user")
        	{
            	user = new TwitterUser(xml);
         	}
         	super.handleResult(event);
        }
	}
}
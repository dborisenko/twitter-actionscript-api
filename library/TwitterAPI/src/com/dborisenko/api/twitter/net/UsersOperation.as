/** UsersOperation.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.net
{
	import com.dborisenko.api.twitter.data.TwitterUser;
	import com.dborisenko.api.twitter.data.collections.UsersCollection;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;

	/**
	 * 
	 * Base operation for work with Collection of Twitter Users
	 * @author Denis Borisenko
	 * 
	 */
	public class UsersOperation extends TwitterOperation
	{
		private var followers:Boolean;
		private var blocked:Boolean;
		
		public function UsersOperation(url:String, followers:Boolean=false, blocked:Boolean=false,
			requiresAuthentication:Boolean=true, params:Object=null)
		{
			super(url, requiresAuthentication, params);
			this.followers = followers;
			this.blocked = blocked;
		}
		
		/**
		 * 
		 * Collection of Twitter Users, received by the operation. 
		 * 
		 */
		[Bindable]
		public function set users(value:ArrayCollection):void
		{
			data = value;
		}
		public function get users():ArrayCollection
		{
			return data as ArrayCollection;
		}
		
		/**
		 * 
		 * @private
		 * 
		 */
		override protected function handleResult(event:Event) : void
        {
			var xml:XML = getXML();
        	if (xml.name() == "users")
        	{
        		users = new ArrayCollection();
        		
        		for each (var item:XML in xml.user)
	        	{
	        		var user:TwitterUser = new TwitterUser(item);
	        		user.isFollower = followers;
	        		user.isBlocked = blocked;
	        		users.addItem(user);
	        	}
         	}
         	else if (xml.name() == "users_list")
         	{
         		users = new UsersCollection();
         		UsersCollection(users).nextCursor = xml.next_cursor.toString();
         		UsersCollection(users).previousCursor = xml.previous_cursor.toString();
         		
         		for each (var itemX:XML in xml.users.user)
	        	{
	        		var userX:TwitterUser = new TwitterUser(itemX);
	        		userX.isFollower = followers;
	        		userX.isBlocked = blocked;
	        		users.addItem(userX);
	        	}
         	}
         	super.handleResult(event);
        }
	}
}
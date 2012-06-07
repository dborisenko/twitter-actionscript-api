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
			
			var json:Object = getJSON();
			var userData:Array = [];
			//if it's a call for a list of users, go ahead and get us some real TwitterUser objects and return them.
			if((json is Array) || (json['users'])){
				
				if(json is Array){
					userData = json as Array;
					users = new ArrayCollection(); //this is a straight list that doesn't have pagination. Like this: https://dev.twitter.com/docs/api/1/get/users/lookup
				}else if(json['users']){
					userData = json['users']; // this will be a paginated list of users. Like this: https://dev.twitter.com/docs/api/1/get/blocks/blocking
					users = new UsersCollection();
					UsersCollection(users).nextCursor = json['next_cursor_str'];
					UsersCollection(users).previousCursor = json['previous_cursor_str'];
				}
				
				for each(var item:Object in userData){
					var user:TwitterUser = new TwitterUser(item);
					user.isFollower = followers;
					user.isBlocked = blocked;
					users.addItem(user);
				}
			}
			//if it's a list of User Ids (we're getting followers or friends, for example), then put the IDs in a UserCollection.
			//It'll be up to the programmer to use the UsersLookup operation to fill out the data.
			if(json['ids']){
				users = new UsersCollection(json['ids']);
				UsersCollection(users).nextCursor = json['next_cursor_str'];
				UsersCollection(users).previousCursor = json['previous_cursor_str'];
			}
			
			
         	super.handleResult(event);
        }
	}
}
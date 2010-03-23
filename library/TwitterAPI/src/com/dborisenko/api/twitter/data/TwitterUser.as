/** TwitterUser.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.data
{
	import mx.events.FlexEvent;
	import com.dborisenko.api.vo.ValueObject;
	
	[Bindable]
	[Event(name="dataChange", type="mx.events.FlexEvent")]
	/**
	 * Twitter User
	 * @author Denis Borisenko
	 * 
	 */
	public class TwitterUser extends ValueObject
	{
		public var id:String;
		public var name:String;
		public var screenName:String;
		public var location:String;
		public var description:String;
		public var profileImageUrl:String;
		public var url:String;
		public var isProtected:Boolean;
		public var friendsCount:Number;
		public var followersCount:Number;
		public var createdAt:Date;
		public var favouritesCount:Number;
		public var utcOffset:String;
		public var timeZone:String;
		private var _following:Boolean;
		public var notifications:Boolean;
		public var statusesCount:Number;
		public var profileBackgroundColor:String;
		public var profileTextColor:String;
		public var profileLinkColor:String;
		public var profileSidebarFillColor:String;
		public var profileSidebarBorderColor:String;
		public var profileBackgroundImageUrl:String;
		public var profileBackgroundTile:String;
		public var status:TwitterStatus;
		
		private var _isFollower:Boolean;
		private var _isBlocked:Boolean;
		
		[Bindable("dataChange")]
		public function get following():Boolean 
		{ 
			return _following;
		}
		public function set following(value:Boolean):void
		{
			if (_following == value)
				return;
			_following = value;
			dispatchDataChangeEvent();
		}
		
		[Bindable("dataChange")]
		public function get isFollower():Boolean 
		{ 
			return _isFollower;
		}
		public function set isFollower(value:Boolean):void
		{
			if (_isFollower == value)
				return;
			_isFollower = value;
			dispatchDataChangeEvent();
		}
		
		[Bindable("dataChange")]
		public function get isBlocked():Boolean 
		{ 
			return _isBlocked;
		}
		public function set isBlocked(value:Boolean):void
		{
			if (_isBlocked == value)
				return;
			_isBlocked = value;
			dispatchDataChangeEvent();
		}
		
		public function TwitterUser(user:Object, isXML:Boolean=true)
		{
			super();
			
			if (user == null)
				return;
			
			if (isXML)
			{
				parseXML(user);
			}
			else
			{
				parseJSON(user);
			}
		
		}
		
		public function parseJSON(user:Object):void
		{
			if (user == null)
				return;
			
			id = user.from_user_id;
			screenName = user.from_user;
			
			name = screenName;
			profileImageUrl = user.profile_image_url;
		}
		
		public function parseXML(user:Object):void
		{
			if (user == null)
				return;
			
			id = user.id;
			name = user.name;
			screenName = user.screen_name;
			location = user.location;
			description = user.description;
			profileImageUrl = user.profile_image_url;
			url = user.url;
			isProtected = ((user.protected != null && user.protected.toString() == "true") ? true : false);
			followersCount = Number(user.followers_count);
			profileBackgroundColor = user.profile_background_color;
			profileTextColor = user.profile_text_color;
			profileLinkColor = user.profile_link_color;
			profileSidebarFillColor = user.profile_sidebar_fill_color;
			profileSidebarBorderColor = user.profile_sidebar_border_color;
			friendsCount = Number(user.friends_count);
			createdAt = new Date(Date.parse(user.created_at.toString()))//CreatedAtDate.parse(user.created_at);
			favouritesCount = Number(user.favourites_count);
			utcOffset = user.utc_offset;
			timeZone = user.time_zone;
			profileBackgroundImageUrl = user.profile_background_image_url;
			profileBackgroundTile = user.profile_background_tile;
			_following = ((user.following != null && user.following.toString() == "true") ? true : false);
			notifications = ((user.notifications != null && user.notifications.toString() == "true") ? true : false);
			statusesCount = Number(user.statuses_count);
			
			if (user.status != null && user.status.toString() != "" && user.status.text != null && user.status.text.toString() != "")
			{
				try
				{
					status = new TwitterStatus(user.status, this);
				}
				catch (e:Error)
				{
					status = null;
				}
			}
		}
		
		protected function dispatchDataChangeEvent():void
		{
			dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
		}
	}
}
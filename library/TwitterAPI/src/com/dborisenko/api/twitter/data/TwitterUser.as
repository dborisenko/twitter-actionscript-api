/** TwitterUser.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.data
{
	import com.dborisenko.api.vo.ValueObject;
	
	import mx.events.FlexEvent;
	
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
		public var profileUseBackgroundImage:Boolean = false;
		public var defaultProfileImage:Boolean = false;
		public var isTranslator:Boolean = false;
		public var followRequestSent:Boolean = false;
		public var contributorsEnabled:Boolean = false;
		public var defaultProfile:Boolean = false;
		public var listedCount:int = 0;
		public var language:String = "en";
		public var geoEnabled:Boolean = false;
		public var verified:Boolean = false;
		public var showAllInlineMedia:Boolean = false;
		
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
		
		public function TwitterUser(user:Object, isXML:Boolean = false, isSearch:Boolean = false)
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
				if(isSearch){
					parseSearchJSON(user);
				}else{
					parseJSON(user);
				}
			}
		
		}
		
		public function parseJSON(user:Object):void{
			if(user == null)
				return;
			
			//why is the order in the API so goofy?
			this.profileSidebarBorderColor = user['profile_sidebar_border_color'];
			this.profileBackgroundImageUrl = user['profile_background_image_url'];
			this.profileSidebarFillColor = user['profile_sidebar_fill_color'];
			this.profileBackgroundTile = user['profile_background_tile'];
			this.profileImageUrl = user['profile_image_url'];
			this.profileUseBackgroundImage = user['profile_use_background_image'];
			this.profileTextColor = user['profile_text_color'];
			this.profileLinkColor = user['profile_link_color'];
			this.profileBackgroundColor = user['profile_background_color'];
			this.defaultProfileImage = user['default_profile_image'];
			
			
			this.id = user['id_str'];
			this.name = user['name'];
			this.screenName = user['screen_name'];
			this.createdAt = new Date(Date.parse(user['created_at']));
			this.language = user['lang'];
			this.description = user['description'];
			this.isProtected = user['protected'];
			this.verified = user['verified'];
			this.url = user['url'];
			
			
			this.friendsCount = user['friends_count'];
			this.statusesCount = user['statuses_count'];
			this.listedCount = user['listed_count'];
			this.followersCount = user['followers_count'];
			
			this.geoEnabled = user['geo_enabled'];
			this.location = user['location'];
			this.timeZone = user['time_zone'];
			this.utcOffset = user['utc_offset'];
			
			this.isTranslator = user['is_translator'];
			this.followRequestSent = user['follow_request_sent'];
			this.contributorsEnabled = user['contributors_enabled'];
			this.defaultProfile = user['default_profile'];
			this.favouritesCount = user['favourites_count']; //seriously, they've gone british on us.
			
			this.showAllInlineMedia = user['show_all_inline_media'];
			this.following = user['following'];
			this.notifications = user['notifications'];
			
			
			if(user['status']){
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
		
		public function parseSearchJSON(user:Object):void
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
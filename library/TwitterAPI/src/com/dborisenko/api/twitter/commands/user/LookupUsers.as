package com.dborisenko.api.twitter.commands.user
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.net.UsersOperation;
	
	/**
	 *Return up to 100 users worth of extended information, specified by either ID, screen name, or combination of the two. 
	 *The author's most recent status (if the authenticating user has permission) will be returned inline.
	 * 
	 *This method is crucial for consumers of the Streaming API. It's also well suited for use in tandem with friends/ids and followers/ids. 
	 * 
	 * 
	 *@author Charlie Szymanski
	 *@see https://dev.twitter.com/docs/api/1/get/users/lookup
	 */ 
	
	public class LookupUsers extends UsersOperation
	{
		
		/**
		 * @private
		 */
		protected static const URL:String = "http://api.twitter.com/1/users/lookup.json";
		
		
		/**
		 * An array of either userIds or screenNames is necessary.
		 * 
		 * @param userIds            Optional. An Array of up to 100 screen names.
		 * 
		 * @param screenNames        Optional. An Array of up to 100 User IDs.
		 * 
		 * @param entities           Optional. Whether or not to include entities in the response statuses.
		 * 
		 */
		public function LookupUsers(userIds:Array = null, screenNames:Array = null, entities:Boolean = true)
		{
			super(URL);
			resultFormat = ResultFormat.JSON;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
			
			var ids:String = null;
			var names:String = null;
			
			if(userIds){
				ids = userIds.join(",");
			}
			
			if(screenNames){
				names = screenNames.join(",");
			}
			
			parameters = {user_id:ids, screen_name:names, include_entities:entities};
		}
	}
}
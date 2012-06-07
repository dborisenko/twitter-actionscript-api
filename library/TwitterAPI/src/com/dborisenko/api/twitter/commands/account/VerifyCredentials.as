/** VerifyCredentials.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.account
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.net.UserOperation;
	
	/**
	 * Returns an HTTP 200 OK response code and a representation of the requesting user if authentication was successful; 
	 * returns a 401 status code and an error message if not.  
	 * Use this method to test if supplied user credentials are valid. 
	 * 
	 * @author Denis Borisenko
	 * @see https://dev.twitter.com/docs/api/1/get/account/verify_credentials
	 */
	public class VerifyCredentials extends UserOperation
	{
		/**
		 * @private
		 * 
		 * @param entities          Optional. Whether or not to include tweet entities in the response status.
		 * 
		 * @param skipStatus        Optional. Whether or not to skip the status in the user response.
		 * 
		 */
		protected static const URL:String = "http://api.twitter.com/1/account/verify_credentials.json";
		
		public function VerifyCredentials(entities:Boolean = true, skipStatus:Boolean = false)
		{
			super(URL);
			resultFormat = ResultFormat.JSON;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = false;
			this.parameters = {include_entities:entities, skip_status:skipStatus};
		}
	}
}
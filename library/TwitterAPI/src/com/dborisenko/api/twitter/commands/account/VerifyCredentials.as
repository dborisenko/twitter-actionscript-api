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
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-account%C2%A0verify_credentials
	 */
	public class VerifyCredentials extends UserOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "http://twitter.com/account/verify_credentials.xml";
		
		public function VerifyCredentials()
		{
			super(URL);
			resultFormat = ResultFormat.XML;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = false;
		}
	}
}
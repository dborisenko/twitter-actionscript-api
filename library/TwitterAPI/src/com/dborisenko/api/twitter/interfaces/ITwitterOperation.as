/** ITwitterOperation.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.interfaces
{
	import com.dborisenko.api.interfaces.IOperation;
	import com.dborisenko.api.twitter.TwitterAPI;
	import com.dborisenko.api.twitter.twitter_internal;
	
	/**
	 * 
	 * Interface for the Twitter Operations.
	 * @author Denis Borisenko
	 * 
	 */
	public interface ITwitterOperation extends IOperation
	{
		/**
		 * 
		 * Is operation requests authentication. 
		 * 
		 */
		function get requiresAuthentication():Boolean;
		
		/**
		 * 
		 * Is operation rate limited.
		 * 
		 */
		function get apiRateLimited():Boolean;
		
		function setTwitterAPI(api:TwitterAPI):void
	}
}
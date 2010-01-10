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
	
	public interface ITwitterOperation extends IOperation
	{
		function get requiresAuthentication():Boolean;
		function get apiRateLimited():Boolean;
	}
}
/** ISinceIdOperation.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2010.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.interfaces
{
	/**
	 * Interface with sinceId value.
	 * @author Denis Borisenko
	 * 
	 */
	public interface ISinceIdOperation
	{
		function get sinceId():String;
		function set sinceId(value:String):void;
	}
}
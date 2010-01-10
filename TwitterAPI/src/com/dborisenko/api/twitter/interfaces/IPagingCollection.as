/** IPagingCollection.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.interfaces
{
	public interface IPagingCollection
	{
		function get nextCursor():String;
		function set nextCursor(value:String):void;
		
		function get previousCursor():String;
		function set previousCursor(value:String):void;
	}
}
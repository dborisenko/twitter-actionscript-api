/** IPagingCollection.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.interfaces
{
	/**
	 * Collection with many pages. The collection is broken into pages. <code>nextCursor</code> and <code>previousCursor</code> -
	 * cursors of next and previous pages.
	 * @author Denis Borisenko
	 * 
	 */
	public interface IPagingCollection
	{
		/**
		 * 
		 * Cursor of the next page.
		 * 
		 */
		function get nextCursor():String;
		function set nextCursor(value:String):void;
		
		/**
		 * 
		 * Cursor of the previous page.
		 * 
		 */
		function get previousCursor():String;
		function set previousCursor(value:String):void;
	}
}
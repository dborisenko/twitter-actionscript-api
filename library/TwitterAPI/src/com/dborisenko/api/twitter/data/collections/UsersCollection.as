/** UsersCollection.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.data.collections
{
	import com.dborisenko.api.twitter.interfaces.IPagingCollection;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	/**
	 * Collection of Twitter Users. Can be broken into pages. In this case, <code>nextCursor</code> and <code>previousCursor</code> -
	 * cursors of next and previous pages.
	 * @author Denis Borisenko
	 * 
	 */
	public class UsersCollection extends ArrayCollection implements IPagingCollection
	{
		private var _nextCursor:String;
		private var _previousCursor:String;
		
		public function UsersCollection(source:Array=null)
		{
			super(source);
		}
		
		/**
		 * 
		 * Cursor of the next page.
		 * 
		 */
		public function get previousCursor():String
		{
			return _previousCursor;
		}

		public function set previousCursor(value:String):void
		{
			_previousCursor = value;
		}

		/**
		 * 
		 * Cursor of the previous page.
		 * 
		 */
		public function get nextCursor():String
		{
			return _nextCursor;
		}

		public function set nextCursor(value:String):void
		{
			_nextCursor = value;
		}
	}
}
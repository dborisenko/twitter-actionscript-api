/** ListsCollection.as
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
	
	public class ListsCollection extends ArrayCollection implements IPagingCollection
	{
		private var _nextCursor:String;
		private var _previousCursor:String;
		
		public function ListsCollection(source:Array=null)
		{
			super(source);
		}

		public function get previousCursor():String
		{
			return _previousCursor;
		}
		public function set previousCursor(value:String):void
		{
			_previousCursor = value;
		}

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
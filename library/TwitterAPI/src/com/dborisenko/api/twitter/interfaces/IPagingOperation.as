/** IPagingOperation.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.interfaces
{
	import com.dborisenko.api.interfaces.IOperation;

	/**
	 * Interface for the multipage collection operations.
	 * @author Denis Borisenko
	 * 
	 */	
	public interface IPagingOperation extends IOperation
	{
		/**
		 * 
		 * Cursor of the current page. 
		 * 
		 */		
		function get cursor():String;
		function set cursor(value:String):void;
	}
}
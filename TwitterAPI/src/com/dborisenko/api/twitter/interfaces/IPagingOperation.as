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

	public interface IPagingOperation extends IOperation
	{
		function get cursor():String;
		function set cursor(value:String):void;
	}
}
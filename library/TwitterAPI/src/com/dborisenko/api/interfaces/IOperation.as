/** IOperation.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.interfaces
{
	import flash.events.IEventDispatcher;

	public interface IOperation extends IEventDispatcher
	{
		function execute():void;
	}
}
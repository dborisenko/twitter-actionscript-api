/** IServiceDelegate.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2010.
 */
package com.dborisenko.api.delegates
{
	import flash.events.IEventDispatcher;

	[Event(name="result",type="mx.rpc.events.ResultEvent")]
	[Event(name="fault",type="mx.rpc.events.FaultEvent")]
	public interface IServiceDelegate extends IEventDispatcher
	{
		function get url():String;
		function set url(value:String):void;
		
		function get headers():Object;
		function set headers(value:Object):void;
		
		function get method():String;
		function set method(value:String):void;
		
		function get params():Object;
		function set params(value:Object):void;
		
		function get resultFormat():String;
		function set resultFormat(value:String):void;
		
		function get lastResult():Object;
		
		function send():void;
	}
}
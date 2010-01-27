/** MemorizeLoader.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2010.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.utils.loaders.memorizeLoaders
{
	import com.dborisenko.api.twitter.TwitterAPI;
	import com.dborisenko.api.twitter.events.TwitterEvent;
	import com.dborisenko.api.twitter.interfaces.ISinceIdOperation;
	import com.dborisenko.api.twitter.net.TwitterOperation;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	[Event(name="complete", type="com.dborisenko.api.twitter.events.TwitterEvent")]
	public class MemorizeLoader extends EventDispatcher
	{
		protected var locked:Boolean = false;
		protected var sinceId:String;
		
		protected var api:TwitterAPI;
		protected var postType:String = TwitterAPI.POST_TYPE_NORMAL;
		protected var priority:int = TwitterAPI.PRIORITY_NORMAL;
		protected var operationClass:Class;
		
		public function MemorizeLoader(api:TwitterAPI, operationClass:Class=null, 
									   postType:String=TwitterAPI.POST_TYPE_NORMAL,
									   priority:int=TwitterAPI.PRIORITY_NORMAL)
		{
			super();
			this.api = api;
			this.postType = postType;
			this.priority = priority;
			this.operationClass = operationClass;
		}
		
		protected function createOperation():TwitterOperation
		{
			return new operationClass();
		}
		
		public function load():void
		{
			if (locked)
				return;
			
			var op:TwitterOperation = createOperation();
			if (op is ISinceIdOperation && sinceId)
			{
				ISinceIdOperation(op).sinceId = sinceId;
			}
			
			var handler:Function = function (event:TwitterEvent):void
			{
				locked = false;
				op.removeEventListener(TwitterEvent.COMPLETE, handler);
				if (event.success)
				{
					var newSinceId:String = readSinceId(event.data);
					if (newSinceId)
					{
						sinceId = newSinceId;
					}
				}
				dispatchCompleteEvent(event);
			};
			
			op.addEventListener(TwitterEvent.COMPLETE, handler);
			locked = true;
			api.post(op, postType, priority);
		}
		
		protected function dispatchCompleteEvent(event:TwitterEvent):void
		{
			dispatchEvent(new TwitterEvent(TwitterEvent.COMPLETE, event.data, event.success));
		}
		
		/**
		 * 
		 * @param data 		The loaded data (array), where we need to read last id.
		 * @return 			The last id. Since this id next loading will be started.
		 * 
		 */
		protected function readSinceId(data:Object):String
		{
			return null;
		}
		
		public function reset():void
		{
			sinceId = null;
		}
		
		public function reload():void
		{
			reset();
			load();
		}
	}
}
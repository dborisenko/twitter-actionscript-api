/** AsyncQueue.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.utils
{
	import com.dborisenko.api.twitter.events.TwitterEvent;
	import com.dborisenko.api.twitter.net.TwitterOperation;
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;

	/**
	 * Async queue class.
	 * @author Denis Borisenko
	 * 
	 */
	public class AsyncQueue
	{
		protected var operationsQueue:ArrayCollection;
		protected var currentOperation:TwitterOperation;
		
		protected var priorities:Dictionary;
		
		public function AsyncQueue()
		{
			operationsQueue = new ArrayCollection();
			priorities = new Dictionary();
			
			var sort:Sort = new Sort();
			sort.compareFunction = function(a:Object, b:Object, fields:Array = null):int
			{
				var o1:Object = priorities[a];
				var o2:Object = priorities[b];
				
				var pos1:int = (o1 != null ? int(o1) : -1);
				var pos2:int = (o2 != null ? int(o2) : -1);
				
				if (pos1 == -1 && pos2 == -1)
					return 0;
				if (pos1 == -1)
					return 1;
				if (pos2 == -1)
					return -1;
				if (pos1 > pos2)
					return -1;
				if (pos1 < pos2)
					return 1;
				return 0;
			};
			operationsQueue.sort = sort;
			
			operationsQueue.refresh();
		}
		
		public function executeOperation(operation:TwitterOperation, priority:int=5):void
		{
			if (!operation)
				return;
			
			operationsQueue.addItem(operation);
			priorities[operation] = priority;
			operationsQueue.refresh();
			
			if (!currentOperation)
			{
				executeNextOperation();
			}
		}
		
		protected function executeNextOperation():void
		{
			if (operationsQueue.length > 0)
			{
				currentOperation = operationsQueue.removeItemAt(0) as TwitterOperation;
				delete priorities[currentOperation];
				currentOperation.addEventListener(TwitterEvent.COMPLETE, handleOperationComplete);
				
				currentOperation.execute();
			}
		}
		
		protected function handleOperationComplete(event:Event):void
		{
			currentOperation.removeEventListener(TwitterEvent.COMPLETE, handleOperationComplete);
			currentOperation = null;
			executeNextOperation();
		}
	}
}
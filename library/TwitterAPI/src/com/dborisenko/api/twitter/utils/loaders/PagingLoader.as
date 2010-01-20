/** PagingLoader.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.utils.loaders
{
	import com.dborisenko.api.events.StatusEvent;
	import com.dborisenko.api.twitter.TwitterAPI;
	import com.dborisenko.api.twitter.events.TwitterEvent;
	import com.dborisenko.api.twitter.interfaces.IPagingCollection;
	import com.dborisenko.api.twitter.interfaces.IPagingOperation;
	import com.dborisenko.api.twitter.net.TwitterOperation;
	
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	
	import mx.collections.ArrayCollection;
	import mx.core.ClassFactory;
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	[Event(name="result", type="mx.rpc.events.ResultEvent")]
	[Event(name="progress", type="flash.events.ProgressEvent")]
	[Event(name="statusChange", type="com.dborisenko.api.events.StatusEvent")]
	public class PagingLoader extends EventDispatcher
	{
		protected static const START_CURSOR:String = "-1";
		
		public static const STATUS_NOT_LOADED:String = "notLoaded";
		public static const STATUS_IN_PROGRESS:String = "inProgress";
		public static const STATUS_FAULT:String = "fault";
		public static const STATUS_COMPLETE:String = "complete";
		public static const STATUS_CANCELED:String = "canceled";
		public static const STATUS_RESETED:String = "reseted";
		
		protected var _list:ArrayCollection;
		
		private var _status:String = STATUS_NOT_LOADED;
		
		protected var api:TwitterAPI;
		protected var postType:String = TwitterAPI.POST_TYPE_NORMAL;
		protected var priority:int = TwitterAPI.PRIORITY_NORMAL;
		protected var operationClassFactory:ClassFactory;
		
		protected var currentOperation:TwitterOperation;
		protected var nextCursor:String = START_CURSOR;
		
		public function PagingLoader(api:TwitterAPI, operationClass:Class, 
											  postType:String=TwitterAPI.POST_TYPE_NORMAL,
											  priority:int=TwitterAPI.PRIORITY_NORMAL, list:ArrayCollection=null)
		{
			super();
			this.api = api;
			this.postType = postType;
			this.priority = priority;
			this.operationClassFactory = new ClassFactory(operationClass);
			this._list = list;
		}
		
		public function get status():String
		{
			return _status;
		}
		
		protected function updateStatus(newStatus:String):void
		{
			if (_status == newStatus)
				return;
			
			var oldStatus:String = _status;
			_status = newStatus;
			dispatchEvent(new StatusEvent(StatusEvent.STATUS_CHANGE, oldStatus, _status));
		}

		public function load():void
		{
			if (status != STATUS_IN_PROGRESS)
			{
				switch (status)
				{
					case STATUS_NOT_LOADED:
					case STATUS_RESETED:
						nextCursor = START_CURSOR;
					case STATUS_FAULT:
					case STATUS_CANCELED:
						executeNextOperation();
						break;
				}
			}
		}
		
		public function cancel():void
		{
			updateStatus(STATUS_CANCELED);
		}
		
		public function reset():void
		{
			if (status != STATUS_IN_PROGRESS)
			{
				nextCursor = START_CURSOR;
				updateStatus(STATUS_RESETED);
			}
		}
		
		public function restart():void
		{
			if (status != STATUS_IN_PROGRESS)
			{
				reset();
				load();
			}
		}
		
		public function get isCompleted():Boolean
		{
			return status == STATUS_COMPLETE;
		}
		
		protected function executeNextOperation():void
		{
			currentOperation = operationClassFactory.newInstance() as TwitterOperation;
			if (currentOperation is IPagingOperation && nextCursor)
			{
				IPagingOperation(currentOperation).cursor = nextCursor;
				
				currentOperation.addEventListener(TwitterEvent.COMPLETE, handleOperationComplete);
				
				updateStatus(STATUS_IN_PROGRESS);
				api.post(currentOperation, postType, priority);
			}
			else
			{
				throw new Error("operationClass must implements IPagingOperation");
			}
		}
		
		protected function handleOperationComplete(event:TwitterEvent):void
		{
			if (event.success)
			{
				if (event.data is IPagingCollection)
				{
					nextCursor = IPagingCollection(event.data).nextCursor;
					
					if (event.data is ArrayCollection)
					{
						if (!_list)
						{
							_list = event.data as ArrayCollection;
						}
						else 
						{
							_list.disableAutoUpdate();
							_list.addAll(event.data as ArrayCollection);
							_list.enableAutoUpdate();
						}
					}
					else
					{
						fault("Incorrect data received from the server");
					}
					
					if (status != STATUS_CANCELED)
					{
						if (nextCursor && nextCursor != "")
						{
							if (nextCursor == "0")
							{
								result();
							}
							else
							{
								progress();
								executeNextOperation();
							}
						}
						else
						{
							fault("Incorrect data received from the server");
						}
					}
				}
				else
				{
					fault("Incorrect data received from the server");
				}
			}
			else
			{
				if (status != STATUS_CANCELED)
				{
					fault(event.data);
				}
			}
		}
		
		protected function result():void
		{
			updateStatus(STATUS_COMPLETE);
			dispatchEvent(new ResultEvent(ResultEvent.RESULT, false, true, list));
		}
		
		protected function fault(info:Object):void
		{
			updateStatus(STATUS_FAULT);
			var f:Fault = info as Fault;
			if (!f && info)
			{
				f = new Fault(info.toString(), info.toString());
			}
			dispatchEvent(new FaultEvent(FaultEvent.FAULT, false, true, f));
		}
		
		protected function progress():void
		{
			updateStatus(STATUS_IN_PROGRESS);
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
		}
		
		public function get list():ArrayCollection
		{
			return _list;
		}
	}
}
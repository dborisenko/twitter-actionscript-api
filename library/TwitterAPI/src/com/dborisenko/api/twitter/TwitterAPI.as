/** TwitterAPI.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter
{
	import com.dborisenko.api.twitter.net.TwitterOperation;
	import com.dborisenko.api.twitter.oauth.OAuthTwitterConnection;
	import com.dborisenko.api.twitter.utils.AsyncQueue;
	
	import flash.events.EventDispatcher;
	
	use namespace twitter_internal;
	
	/**
	 * Twitter API class.
	 * @author Denis Borisenko
	 * 
	 */
	public class TwitterAPI extends EventDispatcher
	{
		/**
		 * Normal post type. Not to put operation in the queue. Execute operation immediately.
		 */
		public static const POST_TYPE_NORMAL:String = "normal";
		/**
		 * Async post type. Put operation in the queue. Execute operation in the queue. 
		 * Each instance has his own queue of operations.
		 */
		public static const POST_TYPE_ASYNC:String = "async";
		/**
		 * Async post type. Put operation in the queue. Execute operation in the static queue.
		 * Common static queue of operations.
		 */
		public static const POST_TYPE_ASYNC_STATIC:String = "asyncStatic";
		
		public static const PRIORITY_LOWEST:int = 1;
		public static const PRIORITY_LOW:int = 3;
		public static const PRIORITY_NORMAL:int = 5;
		public static const PRIORITY_HIGH:int = 7;
		public static const PRIORITY_HIGHEST:int = 9;
		
		/**
		 * Connection of OAuth authentication to Twitter.
		 * @private
		 */
		protected var _connection:OAuthTwitterConnection = new OAuthTwitterConnection();
		/**
		 * Each instance has his own queue of operations.
		 * @private
		 */
		protected var asyncQueue:AsyncQueue = new AsyncQueue();
		
		/**
		 * Common static queue of operations.
		 * @private
		 */
		protected static var staticAsyncQueue:AsyncQueue = new AsyncQueue();
		
		public function TwitterAPI()
		{
			super();
		}
		
		/**
		 * Connection of OAuth authentication to Twitter.
		 */
		public function get connection():OAuthTwitterConnection
		{
			return _connection;
		}
		
		/**
		 * Post operation for executing.
		 * 
		 * @param operation		Instance of the operation.
		 * @param postType		Post type of the operation. 
		 * 						Can be <code>POST_TYPE_NORMAL</code>, <code>POST_TYPE_ASYNC</code> or 
		 * 						<code>POST_TYPE_ASYNC_STATIC</code>
		 * @param priority		Priority of executing of the operation
		 * @return 				Twitter Operation
		 * 
		 */		
		public function post(operation:TwitterOperation, postType:String=POST_TYPE_NORMAL,
							 priority:int=PRIORITY_NORMAL):TwitterOperation
		{
			switch (postType)
			{
				case POST_TYPE_ASYNC:
					return postAsync(operation, priority);
				case POST_TYPE_ASYNC_STATIC:
					return postAsyncStatic(operation, priority);
				case POST_TYPE_NORMAL:
				default:
					return postSync(operation);
			}
			return null;
		}
		
		/**
		 * @private 
		 */
		protected function postAsyncStatic(operation:TwitterOperation, priority:int=PRIORITY_NORMAL):TwitterOperation
		{
			if (operation.requiresAuthentication)
			{
				if (connection.consumer && connection.accessToken)
				{
					operation.twitter_internal::setTwitterAPI(this);
					staticAsyncQueue.executeOperation(operation, priority);
				}
				else
				{
					throw new Error("Cannot post an operation; you need to be authenticated.");
				}
			}
			else
			{
				staticAsyncQueue.executeOperation(operation, priority);
			}
			return operation;
		}
		
		/**
		 * @private 
		 */
		protected function postAsync(operation:TwitterOperation, priority:int=PRIORITY_NORMAL):TwitterOperation
		{
			if (operation.requiresAuthentication)
			{
				if (connection.consumer && connection.accessToken)
				{
					operation.twitter_internal::setTwitterAPI(this);
					asyncQueue.executeOperation(operation, priority);
				}
				else
				{
					throw new Error("Cannot post an operation; you need to be authenticated.");
				}
			}
			else
			{
				asyncQueue.executeOperation(operation, priority);
			}
			return operation;
		}
		
		/**
		 * @private 
		 */
		protected function postSync(operation:TwitterOperation):TwitterOperation
		{
			if (operation.requiresAuthentication)
			{
				if (connection.consumer && connection.accessToken)
				{
					operation.twitter_internal::setTwitterAPI(this);
					operation.execute();
				}
				else
				{
					throw new Error("Cannot post an operation; you need to be authenticated.");
				}
			}
			else
			{
				operation.execute();
			}
			return operation;
		}
	}
}
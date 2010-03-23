/** TwitterEvent.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.events
{
	import com.dborisenko.api.events.DataEvent;

	/**
	 * Event is dispatched by TwitterOperation
	 * @author Denis Borisenko
	 * @see com.dborisenko.api.twitter.net.TwitterOperation
	 */
	public class TwitterEvent extends DataEvent
	{
		/**
		 * When operation complete, TwitterOperation dispatches TwitterEvent.COMPLETE event.
		 * @see com.dborisenko.api.twitter.net.TwitterOperation
		 */
		public static const COMPLETE:String = "complete";
		
		/**
		 * The result of Twitter Operation. 
		 * <code>true</code>, if operation is completed successfully (<code>data</code> contains result).
		 * <code>false</code>, in other case (<code>data</code> contains description of the error).
		 * @see com.dborisenko.api.twitter.net.TwitterOperation
		 */
		public var success:Boolean;
		
		public function TwitterEvent(type:String, data:Object=null, success:Boolean=false, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
			this.success = success;
		}
	}
}
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

	public class TwitterEvent extends DataEvent
	{
		public static const COMPLETE:String = "complete";
		
		public var success:Boolean;
		
		public function TwitterEvent(type:String, data:Object=null, success:Boolean=false, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
			this.success = success;
		}
	}
}
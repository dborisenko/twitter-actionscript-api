/** StatusEvent.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2010.
 */
package com.dborisenko.api.events
{
	import flash.events.Event;
	
	public class StatusEvent extends Event
	{
		public static const STATUS_CHANGE:String = "statusChange";
		
		public var oldStatus:String;
		public var newStatus:String;
		
		public function StatusEvent(type:String, oldStatus:String, newStatus:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.oldStatus = oldStatus;
			this.newStatus = newStatus;
		}
	}
}
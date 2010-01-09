/** DataEvent.as
 * 
 * @author Denis Borisenko
 * 
 * Copyright (c) 2009.
 */
package com.dborisenko.api.events
{
	import flash.events.Event;
	
	public class DataEvent extends Event
	{
		public var data:Object;
		
		public function DataEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
	}
}
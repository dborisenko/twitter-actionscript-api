/** FaultObject.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2010.
 */
package com.dborisenko.api.vo
{
	public class FaultObject extends ValueObject
	{
		[Bindable]
		public var faultString:String;
		[Bindable]
		public var faultBody:Object;
		[Bindable]
		public var sender:Object;
		
		public function FaultObject()
		{
			super();
		}
	}
}
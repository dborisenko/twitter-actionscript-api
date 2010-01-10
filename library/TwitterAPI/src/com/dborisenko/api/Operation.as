/** Operation.as
 * 
 * @author Denis Borisenko
 * 
 * Copyright (c) 2009.
 */
package com.dborisenko.api
{
    import com.dborisenko.api.interfaces.IOperation;
    
    import flash.events.EventDispatcher;
    
    import mx.rpc.IResponder;
    
    public class Operation extends EventDispatcher implements IResponder, IOperation
    {
        public function execute():void {}
		
		public function result(data:Object):void {}
		public function fault(info:Object):void {}
    }
}
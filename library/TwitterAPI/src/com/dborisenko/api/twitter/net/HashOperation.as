/** HashOperation.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.net
{
	import com.dborisenko.api.enums.ResultFormat;
	
	import flash.events.Event;
	import flash.utils.Dictionary;

	/**
	 * 
	 * Base operation for work with Twitter Hash results
	 * @author Denis Borisenko
	 * 
	 */
	public class HashOperation extends TwitterOperation
	{
		public function HashOperation(url:String, requiresAuthentication:Boolean=true, 
									  params:Object=null, resultFormat:String=ResultFormat.XML)
		{
			super(url, requiresAuthentication, params, resultFormat);
		}
		
		/**
		 * 
		 * Hash dictionary, received by the operation. 
		 * 
		 */
		[Bindable]
		public function get hash():Dictionary
		{
			return data as Dictionary;
		}
		public function set hash(value:Dictionary):void
		{
			data = value;
		}
		
		/**
		 * 
		 * @private
		 * 
		 */
		override protected function handleResult(event:Event) : void
		{
			if (!data)
			{
				hash = parseHash(getXML());
			}
			super.handleResult(event);
		}
		
		/**
		 * Parser for the hash dictionary
		 * 
		 */
		protected function parseHash(xml:XML):Dictionary
		{
			var result:Dictionary;
			if (xml.name() == "hash")
			{
				result = new Dictionary();
				for each (var item:XML in xml.children())
				{
					var name:String = item.name().toString();
					var type:String = item.@type.toString();
					var value:Object;
					var str:String = item.text().toString();
					switch (type)
					{
						case "integer":
							value = int(str);
							break;
						case "datetime":
							value = new Date(Date.parse(str.replace(/-/g, "/").replace("T", " ").replace("+", " +")));
							break;
						default:
							value = str;
							break;
					}
					result[name] = value;
				}
			}
			return result;
		}
	}
}
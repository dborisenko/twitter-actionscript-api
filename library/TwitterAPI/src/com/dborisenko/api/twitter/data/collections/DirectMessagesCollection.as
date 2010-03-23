/** DirectMessagesCollection.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.data.collections
{
	import mx.collections.ArrayCollection;

	/**
	 * Collection of Twitter Direct Messages
	 * @author Denis Borisenko
	 * 
	 */
	public class DirectMessagesCollection extends ArrayCollection
	{
		public function DirectMessagesCollection(source:Array=null)
		{
			super(source);
		}
	}
}
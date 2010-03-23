/** StatusesCollection.as
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
	 * Collection of Twitter Statuses
	 * @author Denis Borisenko
	 * 
	 */
	public class StatusesCollection extends ArrayCollection
	{
		public function StatusesCollection(source:Array=null)
		{
			super(source);
		}
		
	}
}
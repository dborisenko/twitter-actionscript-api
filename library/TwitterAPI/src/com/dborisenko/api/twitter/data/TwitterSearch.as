/** TwitterSearch.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.data
{
	import mx.collections.ArrayCollection;
	import com.dborisenko.api.vo.ValueObject;
	
	/**
	 * Twitter Search
	 * @author Denis Borisenko
	 * 
	 */
	public class TwitterSearch extends ValueObject
	{
		public var results:ArrayCollection;
		public var query:String;
	}
}
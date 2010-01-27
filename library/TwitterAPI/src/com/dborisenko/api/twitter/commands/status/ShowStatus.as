/** ShowStatus.as
 * 
 * @author Denis Borisenko
 * 
 * Part of TwitterAPI project. Copyright (c) 2009.
 * http://code.google.com/p/twitter-actionscript-api/
 */
package com.dborisenko.api.twitter.commands.status
{
	import com.dborisenko.api.enums.ResultFormat;
	import com.dborisenko.api.twitter.net.StatusOperation;
	
	/**
	 * Returns a single status, specified by the id parameter below.  The status's author will be returned inline.
	 * 
	 * @author Denis Borisenko
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-statuses%C2%A0show
	 */
	public class ShowStatus extends StatusOperation
	{
		protected static const URL:String = "http://twitter.com/statuses/show/{id}.xml";
		
		/**
		 * 
		 * @param id		Required.  The numerical ID of the status to retrieve.  
		 * 
		 */
		public function ShowStatus(id:String)
		{
			super(URL.replace(/\{id\}/gi, id));
			resultFormat = ResultFormat.XML;
			method = METHOD_GET;
			_requiresAuthentication = true;
			_apiRateLimited = true;
		}
	}
}
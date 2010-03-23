/** UpdateStatus.as
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
	 * Updates the authenticating user's status.  Requires the status parameter specified below.  Request must be a POST.  
	 * A status update with text identical to the authenticating user's current status will be ignored to prevent 
	 * duplicates.
	 * 
	 * @author Denis Borisenko
	 * @see http://apiwiki.twitter.com/Twitter-REST-API-Method%3A-statuses%C2%A0update
	 */
	public class UpdateStatus extends StatusOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "http://twitter.com/statuses/update.xml";
		
		/**
		 * 
		 * @param statusText			Required.  The text of your status update. URL encode as necessary. 
		 * 								Statuses over 140 characters will be forceably truncated.
		 * @param inReplyToStatusId		Optional. The ID of an existing status that the update is in reply to. 
		 * 								Note: This parameter will be ignored unless the author of the tweet this parameter 
		 * 								references is mentioned within the status text. Therefore, you must include @username, 
		 * 								where username is the author of the referenced tweet, within the update.
		 * 
		 */
		public function UpdateStatus(statusText:String, inReplyToStatusId:String=null)
		{
			super(URL);
			resultFormat = ResultFormat.XML;
			method = METHOD_POST;
			_requiresAuthentication = true;
			_apiRateLimited = false;
			parameters = {status: statusText, in_reply_to_status_id: inReplyToStatusId};
		}
	}
}
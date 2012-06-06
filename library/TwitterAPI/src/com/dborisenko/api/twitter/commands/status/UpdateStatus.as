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
	 * There are other options that are not implemented here yet. Mostly geolocation. There is also an update_with_media
	 * API method to upload a picture as well.
	 * 
	 * @author Denis Borisenko
	 * @see https://dev.twitter.com/docs/api/1/post/statuses/update
	 */
	public class UpdateStatus extends StatusOperation
	{
		/**
		 * @private
		 */
		protected static const URL:String = "http://twitter.com/statuses/update.json";
		
		/**
		 * 
		 * @param statusText			Required.  The text of your status update. URL encode as necessary. 
		 * 								Statuses over 140 characters will be forceably truncated.
		 * @param inReplyToStatusId		Optional. The ID of an existing status that the update is in reply to. 
		 * 								Note: This parameter will be ignored unless the author of the tweet this parameter 
		 * 								references is mentioned within the status text. Therefore, you must include @username, 
		 * 								where username is the author of the referenced tweet, within the update.
		 * 
		 * @param entities              Optional. Whether or not to include an entities object in the response.
		 * 
		 * see: https://dev.twitter.com/docs/api/1/post/statuses/update
		 * 
		 */
		public function UpdateStatus(statusText:String, inReplyToStatusId:String = null, entities:Boolean = true)
		{
			resultFormat = ResultFormat.JSON;
			super(URL);
			method = METHOD_POST;
			_requiresAuthentication = true;
			_apiRateLimited = false;
			
			statusText = statusText.replace(/\r\n/g, " ");
			statusText = statusText.replace(/\n/g, " ");
			statusText = statusText.replace(/\r/g, " ");
			
			parameters = {status: statusText, in_reply_to_status_id: inReplyToStatusId, include_entities:entities};
		}
	}
}
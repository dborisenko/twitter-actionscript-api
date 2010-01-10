/** URLUtil.as
 * 
 * @author Denis Borisenko
 * 
 * Copyright (c) 2009.
 */
package com.dborisenko.utils
{
	public class URLUtil
	{
		public static function utf8Encode(string:String):String
		{
			string = string.replace(/\r\n/g,'\n');
			string = string.replace(/\r/g,'\n');
			
			var utfString:String = '';
			
			for (var i:int = 0 ; i < string.length ; i++)
			{
				var chr:Number = string.charCodeAt(i);
				if (chr < 128)
				{
					utfString += String.fromCharCode(chr);
				}
				else if ((chr > 127) && (chr < 2048))
				{
					utfString += String.fromCharCode((chr >> 6) | 192);
					utfString += String.fromCharCode((chr & 63) | 128);
				}
				else
				{
					utfString += String.fromCharCode((chr >> 12) | 224);
					utfString += String.fromCharCode(((chr >> 6) & 63) | 128);
					utfString += String.fromCharCode((chr & 63) | 128);
				}
			}
			
			return utfString;
		}
		
		public static function urlEncode(string:String):String
		{
			var urlString:String = '';
			
			for (var i:int = 0 ; i < string.length ; i++)
			{
				var chr:Number = string.charCodeAt(i);
				
				if ((chr >= 48 && chr <= 57) || // 09
					(chr >= 65 && chr <= 90) || // AZ
					(chr >= 97 && chr <= 122) || // az
					chr == 45 || // -
					chr == 95 || // _
					chr == 46 || // .
					chr == 126) // ~
				{
					urlString += String.fromCharCode(chr);
				}
				else
				{
					urlString += '%' + chr.toString(16).toUpperCase();
				}
			}
			
			return urlString;
		}
		
		public static function encode(string:String):String
		{
			return urlEncode(utf8Encode(string));
		}
		
	}
}
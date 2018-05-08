package com.xl.tool.util
{
	import flash.display.BitmapData;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import mx.graphics.codec.JPEGEncoder;
	

	public class CutItem
	{
		public var bmd:BitmapData;
		public var file:File;
		private var writedCall:Function;
		public function CutItem(fileDic:File,fileName:String,writedCall:Function)
		{
			file = fileDic.resolvePath("small/"+fileName+".jpg");
			this.writedCall = writedCall;
		}
		
		public function saveFile():void
		{
			var jpgEncode:JPEGEncoder = new JPEGEncoder();
			var jpgByteAry:ByteArray = jpgEncode.encode(this.bmd);
			
			var fileStream:FileStream = new FileStream();
			try
			{
				fileStream.open(this.file,FileMode.WRITE);
				fileStream.writeBytes(jpgByteAry);
				fileStream.close();
				
				this.writedCall();
			} 
			catch(error:Error) 
			{
				trace(error.message);
			}
			
		}
	}
}
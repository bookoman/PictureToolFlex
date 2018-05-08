package com.xl.tool.util
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.FileReference;
	
	public class JigsawItem extends Bitmap
	{
		private var loader:Loader;
		private var loadedCall:Function;
		private var file:FileReference;
		
		public var jRow:int;
		public var jCol:int;
		public var jPoint:Point;
		public var bmd:BitmapData;
		
		public function JigsawItem(file:FileReference,jRow:int,jCol:int,loadedCall:Function,bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false)
		{
			super(bitmapData, pixelSnapping, smoothing);
			this.file = file;
			this.jRow = jRow;
			this.jCol = jCol;
			this.loadedCall = loadedCall;
			
			loader = new Loader();
		}
		public function load():void
		{
			file.addEventListener(Event.COMPLETE,onLoadComplete);
			file.load();
			
		}
		public function onLoadComplete(e:Event):void
		{
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaderComplete);
			loader.loadBytes(e.target.data);
		}
		private function onLoaderComplete(e:Event):void
		{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoaderComplete);
			this.bmd = (loader.content as Bitmap).bitmapData;
			this.loadedCall.apply(null,[this]);
		}
	}
}
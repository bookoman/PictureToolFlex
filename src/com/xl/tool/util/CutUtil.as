package com.xl.tool.util
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.flash_proxy;
	
	import morn.core.components.Label;
	import morn.core.components.ProgressBar;

	public class CutUtil
	{
		private var bigFileRer:FileReference;
		private var bigPicBmd:BitmapData;
		private var saveFile:File;
		private var cutItems:Vector.<CutItem>;
		private var lblDic:Label;
		private var progressBar:ProgressBar;
		private var curLoadCount:int;
		private var sumLoadCound:int;
		
		public function CutUtil(lblDic:Label,progressBar:ProgressBar)
		{
			this.lblDic = lblDic;
			this.progressBar = progressBar;
			this.saveFile = new File();
			this.bigFileRer = new FileReference();
			this.saveFile.addEventListener(Event.SELECT,this.onSaveFileDic);
			this.bigFileRer.addEventListener(Event.SELECT,this.onBitPicFileRer);
			this.bigFileRer.addEventListener(Event.COMPLETE,onBitPicLoadComplete);
		}
		private function onSaveFileDic(e:Event):void
		{
			this.lblDic.text = this.saveFile.nativePath;
		}
		private function onBitPicFileRer(e:Event):void
		{
			bigFileRer.load();
		}
		private var loader:Loader;
		private function onBitPicLoadComplete(e:Event):void
		{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaderComplete);
			loader.loadBytes(e.target.data)
		}
		private function onLoaderComplete(e:Event):void
		{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onLoaderComplete);
			this.bigPicBmd = (loader.content as Bitmap).bitmapData;
			
		}
		private function writedCall():void
		{
			this.curLoadCount++;
			if(curLoadCount >= this.sumLoadCound)
			{
				
			}
			this.progressBar.value = this.curLoadCount / this.sumLoadCound;
			this.progressBar.label = Math.ceil(this.progressBar.value * 100) + "%";
		}
		public function choiceBigPicture():void
		{
			bigFileRer.browse([new FileFilter("Images", "*.jpg;*.gif;*.png")]);
		}
		/**
		 * 切割图片
		 */
		public function cutPicture(iw:int,ih:int):void
		{
			
			
			this.cutItems = new Vector.<CutItem>();
			var row:int = this.bigPicBmd.height / ih;
			var lastRowH:int = this.bigPicBmd.height % ih;
			if(lastRowH > 0) row++;
			
			var col:int = this.bigPicBmd.width / iw;
			var lastColW:int = this.bigPicBmd.width % iw;
			if(lastColW > 0) col++;
			
			this.curLoadCount = 0;
			this.sumLoadCound = row * col;
			
			var cutItem:CutItem;
			var tempW:int,tempH:int;
			var p:Point = new Point();
			var fileCount:int;
			for(var i:int = 0;i < row;i++)
			{
				tempH = i < row - 1 ? ih : lastRowH;
				for(var j:int = 0;j < col;j++)
				{
					tempW = j < col - 1 ? iw : lastColW;
					fileCount = i * col + j + 1;
					cutItem = new CutItem(this.saveFile,fileCount + "",writedCall);
					cutItem.bmd = new BitmapData(tempW,tempH);
					cutItem.bmd.copyPixels(this.bigPicBmd,new Rectangle(j*iw,i*ih,tempW,tempH),p);
//					trace(j,i,j*iw,i*ih,tempW,tempH,fileCount);
					App.timer.doFrameOnce(fileCount * 2,cutItem.saveFile,null,false);
				}
			}
			
			
		}
		
		
		public function saveCutPictureDic():void
		{
			this.saveFile.browseForDirectory("选择切割图片路径");
		}
	}
}
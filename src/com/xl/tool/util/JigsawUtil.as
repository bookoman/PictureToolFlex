package com.xl.tool.util
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	import flash.utils.ByteArray;
	
	import mx.graphics.codec.JPEGEncoder;
	
	import morn.core.components.Label;
	import morn.core.components.ProgressBar;
	

	public class JigsawUtil
	{
		private var saveFile:File;
		private var fileReList:FileReferenceList;
		private var lblDic:Label;
		private var progressBar:ProgressBar;
		public var dir:String;
		private var bigBmd:BitmapData;
		private var sumRow:int;
		private var sumCol:int;
		private var bigBmdW:int;
		private var bigBmdH:int;
		private var curLoadCount:int;
		private var sumLoadCound:int;
		private var jigsawItems:Vector.<JigsawItem>;
		
		public function JigsawUtil(lblDic:Label,progressBar:ProgressBar)
		{
			this.progressBar = progressBar;
			this.lblDic = lblDic;
			this.fileReList = new FileReferenceList();
			this.fileReList.addEventListener(Event.SELECT,this.onFileReDir);
			
			this.saveFile = new File();
			this.saveFile.addEventListener(Event.SELECT,this.onSaveFileDic);
		}
		/**
		 * 选择合并文件
		 */
		private function onFileReDir(e:Event):void
		{
			this.fileReList.fileList.sort(function(fileRe1:FileReference,fileRe2:FileReference):int{
				var file1Ind:int = int(fileRe1.name.substr(0,fileRe1.name.length - 4));
				var file2Ind:int = int(fileRe2.name.substr(0,fileRe2.name.length - 4));
				return file1Ind > file2Ind ? 1 : -1;
			});
			this.curLoadCount = 0;
			this.sumLoadCound = this.fileReList.fileList.length;
			
		}
		private function onSaveFileDic(e:Event):void
		{
			this.lblDic.text = this.saveFile.nativePath;
		}
		/**
		 * 加载回调
		 */
		private function loadedCall(jigsawItem:JigsawItem):void
		{
			this.curLoadCount++;
			//结束
			if(this.curLoadCount >= this.sumLoadCound)
			{
				this.saveFileToDir();
			}
			this.progressBar.value = this.curLoadCount / this.sumLoadCound;
			this.progressBar.label = Math.ceil(this.progressBar.value * 100) + "%";
		}
		/**
		 * 保存文件
		 */
		private function saveFileToDir():void
		{
			if(saveFile.isDirectory)
			{
				//计算各个子项坐标
				this.calPreJigsawItemPoint();
				this.bigBmd = new BitmapData(this.bigBmdW,this.bigBmdH);
				
				for each(var item:JigsawItem in this.jigsawItems)
				{
					//用draw由大小限制，绘制不完全
//					this.bigBmd.draw(item.bmd,new Matrix(1,0,0,1,item.jPoint.x,item.jPoint.y)); 
					this.bigBmd.copyPixels(item.bmd,new Rectangle(0,0,item.bmd.width,item.bmd.height),item.jPoint);
//					trace(item.jPoint.x,item.jPoint.y,item.bmd.width,item.bmd.height);
				}
				var jpgEncoder:JPEGEncoder = new JPEGEncoder();
				var imgByteAry:ByteArray = jpgEncoder.encode(this.bigBmd);
				var tempFile:File = saveFile.resolvePath("big/"+ saveFile.name + ".jpg");
				var fileStream:FileStream = new FileStream();
				try
				{
					fileStream.open(tempFile,FileMode.WRITE);
					fileStream.writeBytes(imgByteAry);
					fileStream.close();
				} 
				catch(error:Error) 
				{
					trace(error.message);
				}
			}
		}
		/**
		 * 计算拼图子项得坐标
		 */
		private function calPreJigsawItemPoint():void
		{
			var nextPoint:Point = new Point(0,0);
			var item:JigsawItem;
			for(var i:int = 0;i < this.jigsawItems.length;i++)
			{
				item = this.jigsawItems[i];
				item.jPoint = new Point(nextPoint.x,nextPoint.y);
				//计算bigBmd最大宽高
				if(i % this.sumCol == 0)
				{
					this.bigBmdW = 0;
					this.bigBmdH += item.bmd.height;	
				}
				this.bigBmdW += item.bmd.width;
				//计算下个坐标
				if(item.jCol < this.sumCol - 1)
				{
					nextPoint.x += item.bmd.width;
				}
				else if(item.jCol == this.sumCol - 1)
				{
					nextPoint.x = 0;
					nextPoint.y += item.bmd.height;
				}
//				trace(nextPoint.x,nextPoint.y);
			}
		}
		public function jigsawPic(sumR:int,sumC:int):void
		{
			this.sumRow = sumR;
			this.sumCol = sumC;
			this.jigsawItems = new Vector.<JigsawItem>();
			
			var picAry:Array = this.fileReList.fileList;
			var file:FileReference;
			var jigsawItem:JigsawItem;
			var row:int;
			var col:int;
			for(var i:int = 0;i < picAry.length;i++)
			{
				file = picAry[i];
				row = i / this.sumCol;
				col = i % this.sumCol;
//				trace(row,col);
				jigsawItem = new JigsawItem(file,row,col,loadedCall);
				this.jigsawItems.push(jigsawItem);
				App.timer.doFrameOnce(i* 2,jigsawItem.load,null,false);
			}
			
		}
		public function choicePics():void
		{
			this.fileReList.browse([new FileFilter("Images", "*.jpg;*.gif;*.png")]);
		}
		public function chageSaveDir():void
		{
			this.saveFile.browseForDirectory("合成路径");
		}
		
	}
}
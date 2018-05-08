package com.xl.tool.control
{
	import com.xl.tool.util.CutUtil;
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import ui.CutPictureViewUI;
	
	public class CutPictureViewMediator
	{
		private var cutUtil:CutUtil;
		private var view:CutPictureViewUI;
		private var call:Function = null;
		public function CutPictureViewMediator(call:Function)
		{
			this.call = call;
		}
		public function initView():void
		{
			this.view = new CutPictureViewUI();
			this.cutUtil = new CutUtil(this.view.lblDic,this.view.progressBar);
			App.stage.addChild(this.view);
			
			this.view.btnChoice.addEventListener(MouseEvent.CLICK,this.onBtnChoice);
			this.view.btnCut.addEventListener(MouseEvent.CLICK,this.onBtnCut);
			this.view.btnSaveDic.addEventListener(MouseEvent.CLICK,this.onBtnSaveDic);
			this.view.btnClose.addEventListener(MouseEvent.CLICK,this.onBtnClose);
			
			App.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
		}
		private function onBtnChoice(e:MouseEvent):void
		{
			this.cutUtil.choiceBigPicture();
		}
		private function onBtnSaveDic(e:MouseEvent):void
		{
			this.cutUtil.saveCutPictureDic();
		}
		private function onBtnCut(e:MouseEvent):void
		{
			this.cutUtil.cutPicture(int(this.view.inputWidth.text),int(this.view.inputHeight.text));
		}
		private function onBtnClose(e:MouseEvent):void
		{
			this.dispose();
			this.call();
		}
		private function onKeyUp(e:KeyboardEvent):void
		{
			if(e.charCode == Keyboard.ENTER)
			{
				onBtnCut(null);
			}
		}
		public function dispose():void
		{
			this.view.btnChoice.removeEventListener(MouseEvent.CLICK,this.onBtnChoice);
			this.view.btnCut.removeEventListener(MouseEvent.CLICK,this.onBtnCut);
			this.view.btnSaveDic.removeEventListener(MouseEvent.CLICK,this.onBtnSaveDic);
			this.view.btnClose.removeEventListener(MouseEvent.CLICK,this.onBtnClose);
			App.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
			App.stage.removeChild(this.view);
		}
	}
}
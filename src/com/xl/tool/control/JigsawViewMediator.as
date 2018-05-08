package com.xl.tool.control
{
	import com.xl.tool.util.JigsawUtil;
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import ui.JigsawViewUI;

	public class JigsawViewMediator
	{
		private var view:JigsawViewUI;
		private var jigsawUitl:JigsawUtil;
		private var call:Function = null;
		public function JigsawViewMediator(call:Function)
		{
			this.call = call;
		}
		public function initView():void
		{
			this.view = new JigsawViewUI();
			this.jigsawUitl = new JigsawUtil(this.view.lblDic,this.view.progressBar);
			App.stage.addChild(this.view);
			
			this.view.btnChoice.addEventListener(MouseEvent.CLICK,this.onBtnChoice);
			this.view.btnJoin.addEventListener(MouseEvent.CLICK,this.onBtnJoin);
			this.view.btnSaveDic.addEventListener(MouseEvent.CLICK,this.onBtnSaveDic);
			this.view.btnClose.addEventListener(MouseEvent.CLICK,this.onBtnClose);
			
			App.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
		}
		private function onBtnChoice(e:MouseEvent):void
		{
			jigsawUitl.choicePics();
		}
		private function onBtnSaveDic(e:MouseEvent):void
		{
			jigsawUitl.chageSaveDir();
		}
		private function onBtnJoin(e:MouseEvent):void
		{
			jigsawUitl.jigsawPic(int(this.view.inputRow.text),int(this.view.inputCol.text));
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
				onBtnJoin(null);
			}
		}

		public function dispose():void
		{
			this.view.btnChoice.removeEventListener(MouseEvent.CLICK,this.onBtnChoice);
			this.view.btnJoin.removeEventListener(MouseEvent.CLICK,this.onBtnJoin);
			this.view.btnSaveDic.removeEventListener(MouseEvent.CLICK,this.onBtnSaveDic);
			this.view.btnClose.removeEventListener(MouseEvent.CLICK,this.onBtnClose);
			App.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
			App.stage.removeChild(this.view);
		}
	}
}
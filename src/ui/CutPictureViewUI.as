/**Created by Morn,Do not modify.*/
package ui {
	import morn.core.components.*;
	public class CutPictureViewUI extends View {
		public var lblDic:Label;
		public var btnSaveDic:Button;
		public var inputWidth:TextInput;
		public var btnChoice:Button;
		public var inputHeight:TextInput;
		public var btnCut:Button;
		public var btnClose:Button;
		public var progressBar:ProgressBar;
		protected var uiXML:XML =
			<View>
			  <Image url="png.comp.blank" x="198" y="167" width="417" height="41"/>
			  <Label text="合成路径：" x="92" y="174" size="20"/>
			  <Label x="198" y="174" size="20" width="415" height="29" var="lblDic" buttonMode="false" underline="false" bold="false"/>
			  <Button label="浏览" skin="png.comp.button" x="631" y="177" labelSize="20" var="btnSaveDic"/>
			  <TextInput skin="png.comp.textinput" x="313" y="265" var="inputWidth" width="60" height="22"/>
			  <Label text="宽：" x="264" y="261" size="20" toolTip="输入&quot;row,col&quot;格式，算出行列拼图" align="right" width="39" height="30"/>
			  <Button label="选择图片" skin="png.comp.button" x="425" y="283" labelSize="18" var="btnChoice"/>
			  <TextInput skin="png.comp.textinput" x="313" y="302" var="inputHeight" width="60" height="22"/>
			  <Label text="高：" x="264" y="298" size="20" toolTip="输入&quot;row,col&quot;格式，算出行列拼图" align="right" width="38" height="30"/>
			  <Button label="切割" skin="png.comp.button" x="283" y="418" labelSize="30" var="btnCut" width="222" height="59"/>
			  <Button skin="png.comp.btn_close" x="741" y="24" var="btnClose"/>
			  <ProgressBar skin="png.comp.progress" x="223" y="348" width="351" height="14" var="progressBar" value="0" label="0%" sizeGrid="10,2,10,2"/>
			  <Label text="切割进度" x="352" y="378" size="20"/>
			</View>;
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}
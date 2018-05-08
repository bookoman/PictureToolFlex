/**Created by Morn,Do not modify.*/
package ui {
	import morn.core.components.*;
	public class JigsawViewUI extends View {
		public var lblDic:Label;
		public var btnSaveDic:Button;
		public var btnJoin:Button;
		public var inputRow:TextInput;
		public var btnChoice:Button;
		public var progressBar:ProgressBar;
		public var inputCol:TextInput;
		public var btnClose:Button;
		protected var uiXML:XML =
			<View>
			  <Image url="png.comp.blank" x="217" y="116" width="417" height="41"/>
			  <Label text="切割路径：" x="111" y="123" size="20"/>
			  <Label x="217" y="123" size="20" width="415" height="29" var="lblDic" buttonMode="false" underline="false" bold="false"/>
			  <Button label="浏览" skin="png.comp.button" x="650" y="126" labelSize="20" var="btnSaveDic"/>
			  <Button label="合成" skin="png.comp.button" x="287" y="406" labelSize="30" var="btnJoin" width="222" height="59"/>
			  <TextInput skin="png.comp.textinput" x="332" y="214" var="inputRow" width="45" height="22"/>
			  <Label text="行：" x="283" y="210" size="20" toolTip="输入&quot;row,col&quot;格式，算出行列拼图" align="right" width="39" height="30"/>
			  <Button label="选择图片" skin="png.comp.button" x="425" y="230" labelSize="18" var="btnChoice"/>
			  <ProgressBar skin="png.comp.progress" x="233" y="333" width="351" height="14" var="progressBar" value="0" label="0%" sizeGrid="10,2,10,2"/>
			  <Label text="合成进度" x="362" y="363" size="20"/>
			  <TextInput skin="png.comp.textinput" x="332" y="251" var="inputCol" width="45" height="22"/>
			  <Label text="列：" x="283" y="247" size="20" toolTip="输入&quot;row,col&quot;格式，算出行列拼图" align="right" width="38" height="30"/>
			  <Button skin="png.comp.btn_close" x="750" y="23" var="btnClose"/>
			</View>;
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}
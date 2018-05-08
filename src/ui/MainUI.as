/**Created by Morn,Do not modify.*/
package ui {
	import morn.core.components.*;
	public class MainUI extends View {
		public var btnJoin:Button;
		public var btnCut:Button;
		protected var uiXML:XML =
			<View>
			  <Button label="合成" skin="png.comp.button" x="178" y="267" labelSize="30" var="btnJoin" width="222" height="59"/>
			  <Button label="切割" skin="png.comp.button" x="430" y="267" labelSize="30" var="btnCut" width="222" height="59"/>
			</View>;
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}
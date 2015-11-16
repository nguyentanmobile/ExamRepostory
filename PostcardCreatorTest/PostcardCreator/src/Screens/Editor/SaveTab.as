package Screens.Editor 
{
	import air.net.ServiceMonitor;
	import feathers.controls.Screen;
	import feathers.controls.text.TextFieldTextEditor;
	import flash.text.TextFormat;
	import starling.display.Quad;
	import Utils.Utilities;
	
	/**
	 * ...
	 * @author NGUYEN NGOC TAN
	 */
	public class SaveTab extends Screen 
	{
		
		public function SaveTab(id:int) 
		{
			super();
			var background:Quad =  new Quad(Utilities.GetScaledX(0.5), Utilities.GetScaledX(0.2), 0x0c75b1);
			var title:TextFieldTextEditor = new TextFieldTextEditor();
			title.text = "this is tab " + id;
			title.alignPivot();
			title.width = background.width;
			//title.x = background.width / 2 ;
			title.y = background.height / 2;
			var textFormat:TextFormat = new TextFormat("SourceSansPro", 30, 0xffffff);
			textFormat.align =  "center"
			title.textFormat = textFormat;
			title.embedFonts = true;
			addChild(background);
			addChild(title);
			
		}
		
	}

}
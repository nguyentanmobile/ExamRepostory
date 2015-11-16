package Controls 
{
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Panel;
	import feathers.controls.ScrollContainer;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import Utils.AssetsManager;
	import Utils.Utilities;
	
	/**
	 * ...
	 * @author Andrew Jarman
	 */
	public class InfoPanel extends Sprite 
	{
		private var panel:ScrollContainer;
		
		private var _width:Number;
		private var firstLabel:Boolean = true;
		
		public function InfoPanel(width:Number) 
		{
			super();
			
			_width = width;
			
			panel = new ScrollContainer();
			panel.styleNameList.add("infoContainer");
			
			addChild(panel);
			
			
		}
		
		public function addtext(text:String):void
		{
			if (!firstLabel)
			{
				panel.addChild(getLine());
			}
			else
				firstLabel = false;
			
			var layout:HorizontalLayout = new HorizontalLayout();
			layout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
			layout.gap = 10;
 
			var container:LayoutGroup = new LayoutGroup();
			container.layout = layout;
			panel.addChild( container );
			
			var icon:Image = new Image(AssetsManager.getAtlas().getTexture("PCC_TipIcon"));
			icon.width = Utilities.GetScaledX(0.03);
			icon.scaleY = icon.scaleX;
			container.addChild(icon);
			
			var label:Label = new Label();
			label.styleNameList.add("infoLabel");
			label.text = text;
			
			
			label.wordWrap = true;
			label.width = _width;
			container.addChild(label);
			
			
		}
		
		public function getLine():Quad
		{
			return new Quad( _width * 0.9 , 1 , 0x0F4B56, true);
		}
		
		
		
	}

}
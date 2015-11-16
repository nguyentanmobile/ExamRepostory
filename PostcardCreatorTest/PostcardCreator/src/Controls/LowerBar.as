package Controls 
{
	import feathers.controls.Label;
	import starling.display.Sprite;
	import flash.sampler.NewObjectSample;
	import starling.display.Quad;
	import Utils.Utilities;
	
	/**
	 * ...
	 * @author Andrew Jarman
	 */
	public class LowerBar extends Sprite 
	{
		private var background:Quad;
		private var label:Label;
		
		public function LowerBar(labelText:String) 
		{
			super();
			
			
			
			label = new Label();
			label.text = labelText;
			label.validate();
			
			background = new Quad( Utilities.GetScaledX(1), Utilities.GetScaledY(0.07), 0x74a3ac );
			background.alignPivot();
			background.y = Utilities.GetScaledY(0.8);
			background.x = Utilities.GetScaledX(0.5);
			
			label.alignPivot();
			label.y = background.y;
			label.x = Utilities.GetScaledX(0.5);
			
			addChild(background);
			addChild(label);
		}
		
		public function set text(value:String):void 
		{
			label.text = value;
		}
		
		
		
	}

}
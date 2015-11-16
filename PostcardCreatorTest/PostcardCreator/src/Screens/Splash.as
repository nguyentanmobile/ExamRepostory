package Screens 
{
	import feathers.controls.Label;
	import feathers.controls.ProgressBar;
	import feathers.controls.Screen;
	import flash.utils.clearInterval;
	import flash.utils.clearTimeout;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import Utils.AssetsManager;
	import Utils.Utilities;
	
	/**
	 * ...
	 * @author Andrew Jarman
	 */
	public class Splash extends Screen 
	{
		
		public static const COMPLETE:String = "complete";
		
		private static const delay:Number = 5;
		private var timer:uint;
		private static const CanSkipSplash:Boolean = false;
		private var intervalID:uint;
		private var progress:ProgressBar;
		
		public function Splash() 
		{
			super();
			
			var quad:Quad = new Quad(Starling.current.stage.stageWidth, Starling.current.stage.stageHeight, 0xffffff);
			addChild(quad);
			
			intervalID = setInterval(onTick, 10);
			
			
			var tempLabel:Label = new Label();
			tempLabel.styleNameList.add("Title");
			tempLabel.text = "Postcard Creator";
			tempLabel.validate();
			tempLabel.alignPivot();
			tempLabel.x = Utils.Utilities.GetScaledX(0.5);
			tempLabel.y = Utils.Utilities.GetScaledY(0.35);
			addChild(tempLabel);
			
			progress = new ProgressBar();
			progress.width = Utils.Utilities.GetScaledX(0.5);
			progress.validate();
			progress.alignPivot();
			progress.minimum = 0;
			progress.maximum = 100;
			progress.value = 0;
			progress.x = Utils.Utilities.GetScaledX(0.5);
			progress.y = Utils.Utilities.GetScaledY(0.5);
			
			this.addChild( progress );
			
			var logo:Image = new Image(AssetsManager.getAtlas().getTexture("PCC_RWT"));
			addChild(logo);
			logo.alignPivot();
			logo.x = Utilities.GetScaledX(0.5);
			logo.y = Utilities.GetScaledY(0.7);
			
		}
		
		private function onTick():void 
		{
			progress.value = Math.min(progress.value + 2, 100);
			if (progress.value == 100)
			{
				clearInterval(intervalID);
				this.dispatchEventWith( COMPLETE );
			}
		}
		
	}

}
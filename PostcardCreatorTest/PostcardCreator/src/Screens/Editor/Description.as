package Screens.Editor 
{
	import Controls.InfoPanel;
	import Controls.LowerBar;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Panel;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import StoredObject.SharedObjectManager;
	import Utils.Utilities;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Description extends Screen 
	{
		public static const SHOW_MAILINGADDRESS:String = "show_MailingAddress";
		public static const SHOW_MESSAGE:String = "show_message";
		
		private var title:Label;
		private var panel:InfoPanel;
		private var instructions:Label;
		private var ImageTitle:Label;
		private var inputImageTitle:TextInput;
		private var next:Button;
		private var back:Button;
		private var ImageDescription:Label;
		private var spacing:Number = Utils.Utilities.GetScaledY(0.01);
		private var inputImageDescription:TextInput;
		private var ImageCredit:Label;
		private var inputImageCredit:TextInput;
		
		public function Description() 
		{
			super();
			
			title = new Label();
			title.text = "Postcard Description";
			title.x = Utils.Utilities.GetScaledX(0.05);
			title.y = Utils.Utilities.GetScaledY(0.05);
			addChild(title);
			
			var lowerBar:Controls.LowerBar = new Controls.LowerBar("Type the description of the picture for the front of the postcard.");
			addChild(lowerBar);
			
			instructions = new Label();
			instructions.wordWrap = true;
			instructions.text = "Type the description of the scene or images that you will create for the front of the prostcard.  The description appears on the upper left corner of the postcard.\n\n" +
			"If you need to document the source of an image, be sure to include that information here too.";
			
			instructions.width = Utils.Utilities.GetScaledX(0.25);
			
			
			panel = new InfoPanel(Utils.Utilities.GetScaledX(0.18));
			panel.x = Utils.Utilities.GetScaledX(0.025);
			panel.y = Utils.Utilities.GetScaledY(0.1)
			
			
			panel.addtext("The description appears on the upper left corner of the postcard.");
			panel.addtext("If you need to document the source of an image, be sure to include that information.");
			addChild(panel);
			
			
			ImageTitle = new Label();
			ImageTitle.text = "Image Title";
			ImageTitle.x = Utils.Utilities.GetScaledX(0.42);
			ImageTitle.y = Utils.Utilities.GetScaledY(0.05);
			addChild(ImageTitle);
			ImageTitle.validate();
			
			
			inputImageTitle = new TextInput();
			inputImageTitle.x = ImageTitle.x;
			inputImageTitle.y = (ImageTitle.y + ImageTitle.height) + spacing + spacing;
			inputImageTitle.width = Utils.Utilities.GetScaledX(0.5);
			addChild(inputImageTitle);
			inputImageTitle.validate();
			inputImageTitle.addEventListener(Event.CHANGE, inputImageTitle_change);
			inputImageTitle.verticalAlign = TextInput.VERTICAL_ALIGN_TOP;
			inputImageTitle.text = SharedObjectManager.getCurrentProject().imageTitle;
			
			
			ImageDescription = new Label();
			ImageDescription.text = "Image Descripton";
			ImageDescription.x = inputImageTitle.x;
			ImageDescription.y = inputImageTitle.y + inputImageTitle.height + spacing;
			addChild(ImageDescription);
			ImageDescription.validate();
			
			inputImageDescription = new TextInput();
			inputImageDescription.x = ImageDescription.x;
			inputImageDescription.y = (ImageDescription.y + ImageDescription.height) + spacing;
			inputImageDescription.width = Utils.Utilities.GetScaledX(0.5);
			inputImageDescription.height = Utils.Utilities.GetScaledY(0.3);
			addChild(inputImageDescription);
			inputImageDescription.validate();
			inputImageDescription.addEventListener(Event.CHANGE, inputImageDescription_change);
			inputImageDescription.verticalAlign = TextInput.VERTICAL_ALIGN_TOP;
			inputImageDescription.text = SharedObjectManager.getCurrentProject().imageDescription;
			
			ImageCredit = new Label();
			ImageCredit.text = "Image Credit";
			ImageCredit.x = inputImageDescription.x;
			ImageCredit.y = (inputImageDescription.y + inputImageDescription.height) + spacing;
			addChild(ImageCredit);
			ImageCredit.validate();
			
			inputImageCredit = new TextInput();
			inputImageCredit.x = ImageCredit.x;
			inputImageCredit.y = (ImageCredit.y + ImageCredit.height) + spacing;
			inputImageCredit.width = Utils.Utilities.GetScaledX(0.5);
			addChild(inputImageCredit);
			inputImageCredit.validate();
			inputImageCredit.addEventListener(Event.CHANGE, inputImageCredit_change);
			inputImageCredit.verticalAlign = TextInput.VERTICAL_ALIGN_TOP;
			inputImageCredit.text = SharedObjectManager.getCurrentProject().imageCredit;
			
			
			
			back = new Button();
			back.label = "Back";
			back.styleNameList.add("Back");
			back.addEventListener( TouchEvent.TOUCH, onBackTouched );
			back.width = Utils.Utilities.GetScaledX(0.2);
			back.validate();
			back.alignPivot();
			back.x = Utils.Utilities.GetScaledX(0.125);
			back.y = Utils.Utilities.GetScaledY(0.8);
			
			addChild(back);
			
			
			next = new Button();
			next.label = "Next";
			next.styleNameList.add("Next");
			addChild(next);
			next.addEventListener( TouchEvent.TOUCH, onNextTouched );
			next.width = Utils.Utilities.GetScaledX(0.2);
			next.validate();
			next.alignPivot();
			next.x = Utils.Utilities.GetScaledX(0.875);
			next.y = Utils.Utilities.GetScaledY(0.8);
		}
		
		private function inputImageCredit_change(e:Event):void 
		{
			SharedObjectManager.getCurrentProject().imageCredit = inputImageCredit.text;
		}
		
		private function inputImageDescription_change(e:Event):void 
		{
			SharedObjectManager.getCurrentProject().imageDescription = inputImageDescription.text;
		}
		
		private function inputImageTitle_change(e:Event):void 
		{
			SharedObjectManager.getCurrentProject().imageTitle = inputImageTitle.text;
		}
		
		private function onNextTouched(e:TouchEvent):void 
		{
			if ( e.getTouch( next, TouchPhase.ENDED ) )
			{
				this.dispatchEventWith( SHOW_MESSAGE );
			}
		}
		
		private function onBackTouched(e:TouchEvent):void 
		{
			if ( e.getTouch( back, TouchPhase.ENDED ) )
			{
				this.dispatchEventWith( SHOW_MAILINGADDRESS );
			}
		}
		
	}

}
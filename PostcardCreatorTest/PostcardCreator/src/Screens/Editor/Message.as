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
	public class Message extends Screen 
	{
		public static const SHOW_STAMP:String = "show_Stamp";
		public static const SHOW_DESCRIPTION:String = "show_Description";
		
		private var title:Label;
		private var panel:InfoPanel;
		private var instructions:Label;
		private var Greeting:Label;
		private var inputGreeting:TextInput;
		private var next:Button;
		private var back:Button;
		private var instructionsBody:Label;
		private var instructionsClosing:Label;
		private var spacing:Number = Utils.Utilities.GetScaledY(0.01);
		private var Body:Label;
		private var inputBody:TextInput;
		private var Closing:Label;
		private var inputClosing:TextInput;
		private var SendersName:Label;
		private var inputSendersName:TextInput;
		
		public function Message() 
		{
			super();
			
			title = new Label();
			title.text = "Postcard Message";
			title.x = Utils.Utilities.GetScaledX(0.05);
			title.y = Utils.Utilities.GetScaledY(0.05);
			addChild(title);
			
			var lowerBar:Controls.LowerBar = new Controls.LowerBar("Type the message of your postcard.");
			addChild(lowerBar);
			
			
			
			instructions = new Label();
			instructions.wordWrap = true;
			instructions.width = Utils.Utilities.GetScaledX(0.25);
			instructions.text = "Type the message for your postcard here, in each of the parts.  The message appears in the lower left of the postcard.\n\n" +
			"Example:";
			instructions.validate();
			
			instructionsBody = new Label();
			instructionsBody.wordWrap = true;
			instructionsBody.width = Utils.Utilities.GetScaledX(0.20);
			instructionsBody.text = "Dead Dad,\n"+
			"I just visited this great museum in Chicago that has dinosaurs and stuff on science.  It was really a lot of fun.  I wish you could have come with us.";
			instructionsBody.y = instructions.height + Utils.Utilities.GetScaledY(0.01);
			instructionsBody.x = Utils.Utilities.GetScaledX(0.025);
			instructionsBody.validate();
			
			instructionsClosing = new Label();
			instructionsClosing.wordWrap = true;
			instructionsClosing.text = "Love,\nTravis";
			instructionsClosing.y = instructionsBody.y + instructionsBody.height + Utils.Utilities.GetScaledY(0.01);;
			instructionsClosing.x = Utils.Utilities.GetScaledX(0.175);
			
			
			panel = new InfoPanel(Utils.Utilities.GetScaledX(0.18));
			panel.x = Utils.Utilities.GetScaledX(0.025);
			panel.y = Utils.Utilities.GetScaledY(0.1)
			
			
			panel.addtext("The message appears in the lower left part of the postcard.");
			addChild(panel);
			
			
			
			Greeting = new Label();
			Greeting.text = "Greeting";
			Greeting.x = Utils.Utilities.GetScaledX(0.42);
			Greeting.y = Utils.Utilities.GetScaledY(0.05);
			addChild(Greeting);
			Greeting.validate();
			
			
			inputGreeting = new TextInput();
			inputGreeting.x = Utils.Utilities.GetScaledX(0.42);
			inputGreeting.y = Greeting.y + Greeting.height + spacing + spacing;
			inputGreeting.width = Utils.Utilities.GetScaledX(0.5);
			addChild(inputGreeting);
			inputGreeting.addEventListener(Event.CHANGE, inputGreeting_change);
			inputGreeting.verticalAlign = TextInput.VERTICAL_ALIGN_TOP;
			inputGreeting.text = SharedObjectManager.getCurrentProject().greeting;
			inputGreeting.validate();
			
			Body = new Label();
			Body.text = "Body";
			Body.x = Utils.Utilities.GetScaledX(0.42);
			Body.y = inputGreeting.y + inputGreeting.height + spacing;
			addChild(Body);
			Body.validate();
			
			
			inputBody = new TextInput();
			inputBody.x = Utils.Utilities.GetScaledX(0.42);
			inputBody.y = Body.y + Body.height + spacing;
			inputBody.width = Utils.Utilities.GetScaledX(0.5);
			inputBody.height = Utils.Utilities.GetScaledY(0.21);
			addChild(inputBody);
			inputBody.addEventListener(Event.CHANGE, inputBody_change);
			inputBody.verticalAlign = TextInput.VERTICAL_ALIGN_TOP;
			inputBody.text = SharedObjectManager.getCurrentProject().body;
			inputBody.validate();
			
			
			
			
			Closing = new Label();
			Closing.text = "Closing";
			Closing.x = Utils.Utilities.GetScaledX(0.42);
			Closing.y = inputBody.y + inputBody.height + spacing;
			addChild(Closing);
			Closing.validate();
			
			
			inputClosing = new TextInput();
			inputClosing.x = Utils.Utilities.GetScaledX(0.42);
			inputClosing.y = Closing.y + Closing.height + spacing;
			inputClosing.width = Utils.Utilities.GetScaledX(0.5);
			addChild(inputClosing);
			inputClosing.addEventListener(Event.CHANGE, inputClosing_change);
			inputClosing.verticalAlign = TextInput.VERTICAL_ALIGN_TOP;
			inputClosing.text = SharedObjectManager.getCurrentProject().closing;
			inputClosing.validate();
			
			
			SendersName = new Label();
			SendersName.text = "Sender's Name";
			SendersName.x = Utils.Utilities.GetScaledX(0.42);
			SendersName.y = inputClosing.y + inputClosing.height + spacing;
			addChild(SendersName);
			SendersName.validate();
			
			
			inputSendersName = new TextInput();
			inputSendersName.x = Utils.Utilities.GetScaledX(0.42);
			inputSendersName.y = SendersName.y + SendersName.height + spacing;
			inputSendersName.width = Utils.Utilities.GetScaledX(0.5);
			addChild(inputSendersName);
			inputSendersName.addEventListener(Event.CHANGE, inputSendersName_change);
			inputSendersName.verticalAlign = TextInput.VERTICAL_ALIGN_TOP;
			inputSendersName.text = SharedObjectManager.getCurrentProject().sendersName;
			inputSendersName.validate();
			
			
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
		
		private function inputSendersName_change(e:Event):void 
		{
			SharedObjectManager.getCurrentProject().sendersName = inputSendersName.text;
		}
		
		private function inputClosing_change(e:Event):void 
		{
			SharedObjectManager.getCurrentProject().closing = inputClosing.text;
		}
		
		private function inputBody_change(e:Event):void 
		{
			SharedObjectManager.getCurrentProject().body = inputBody.text;
		}
		
		private function inputGreeting_change(e:Event):void 
		{
			SharedObjectManager.getCurrentProject().greeting = inputGreeting.text;
		}
		
		private function onNextTouched(e:TouchEvent):void 
		{
			if ( e.getTouch( next, TouchPhase.ENDED ) )
			{
				this.dispatchEventWith( SHOW_STAMP );
			}
		}
		
		private function onBackTouched(e:TouchEvent):void 
		{
			if ( e.getTouch( back, TouchPhase.ENDED ) )
			{
				this.dispatchEventWith( SHOW_DESCRIPTION );
			}
		}
		
	}

}
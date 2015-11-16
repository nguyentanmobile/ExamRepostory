package PostcardLayouts 
{
	import feathers.controls.Callout;
	import feathers.controls.Label;
	import feathers.controls.text.TextBlockTextRenderer;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	import feathers.themes.BaseMetalWorksMobileTheme;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontPosture;
	import flash.text.engine.FontWeight;
	import flash.text.engine.RenderingMode;
	import flash.text.TextFormat;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import Utils.AssetsManager;
	import Utils.Utilities;
	
	/**
	 * ...
	 * @author Andrew Jarman
	 */
	public class OverviewPostcard extends Sprite 
	{
		private var description:Label;
		private var greeting:Label;
		private var body:Label;
		private var address:Label;
		private var closing:Label;
		private var sender:Label;
		
		
		public function OverviewPostcard(width:Number, height:Number) 
		{
			super();
			
			var outerBackground:Quad = new Quad(width*1.02, height*1.025, 0x000000)
			outerBackground.alpha = 0.1;
			outerBackground.y = 5
			addChild(outerBackground);
			
			var innerBackground:Quad = new Quad(width, height, 0xffffff)
			innerBackground.x = width * 0.01;
			addChild(innerBackground);
			
			var top:Image = new Image(AssetsManager.getAtlas().getTexture("PCC_LetterTopBar"));
			addChild(top);
			top.alignPivot();
			top.width = innerBackground.width*0.988;
			top.scaleY = top.scaleX;
			top.x = (innerBackground.width * 0.5) + innerBackground.x;
			top.y = top.height;
			
			var bottom:Image = new Image(AssetsManager.getAtlas().getTexture("PCC_LetterTopBar"));
			addChild(bottom);
			bottom.alignPivot();
			bottom.width = innerBackground.width*0.988;
			bottom.scaleY = bottom.scaleX;
			bottom.x = (innerBackground.width * 0.5) + innerBackground.x;
			bottom.y = innerBackground.height - bottom.height;
			
			var left:Image = new Image(AssetsManager.getAtlas().getTexture("PCC_LetterLeftBar"));
			addChild(left);
			left.alignPivot();
			left.height = innerBackground.height*0.973;
			left.scaleX = left.scaleY;
			left.x = left.width + innerBackground.x
			left.y = innerBackground.height * 0.5;
			
			var right:Image = new Image(AssetsManager.getAtlas().getTexture("PCC_LetterLeftBar"));
			addChild(right);
			right.alignPivot();
			right.height = innerBackground.height * 0.973;
			right.scaleX = right.scaleY;
			right.x = (innerBackground.width - left.width) + innerBackground.x;
			right.y = innerBackground.height * 0.5;
			
			
			description = new Label();			
			description.styleNameList.add("dark-label");
			description.text = "A Dinosaur Named Sue\nSue is the largest T.rex skeleton evet found.\nThe fossil is a permanent exhibit at The Field\nMuseum in Chicago.\nPhoto © The Field Museum";
			description.addEventListener(TouchEvent.TOUCH, onDescriptionTouch);
			addChild(description);
			description.x = Utilities.GetScaledX(0.03);
			description.y = Utilities.GetScaledY(0.03);
			description.validate();
			
			greeting = new Label();
			greeting.styleNameList.add("dark-label");
			greeting.text = "Dear Dad,";
			greeting.x = description.x;
			greeting.y = description.y + description.height + Utils.Utilities.GetScaledX(0.025);
			greeting.addEventListener(TouchEvent.TOUCH, onGreetingTouch);
			addChild(greeting);
			greeting.validate();
			
			body = new Label();
			body.styleNameList.add("dark-label");
			body.wordWrap = true;
			body.text = "I just visited this great museum in Chicago that has dinosaurs and stuff on science. It was really a lof of fun. I wish you could have come with us.";
			body.x = greeting.x;
			body.y = greeting.y + (greeting.height * 1.5);
			body.width = width * 0.40;
			body.addEventListener(TouchEvent.TOUCH, onBodyTouch);
			addChild(body);
			body.validate();
			
			closing = new Label();
			closing.styleNameList.add("dark-label");
			closing.wordWrap = true;
			closing.text = "Love,";
			closing.x = width * 0.35;
			closing.y = body.y + body.height;
			closing.addEventListener(TouchEvent.TOUCH, onClosingTouch);
			addChild(closing);
			closing.validate();
			
			
			sender = new Label();
			sender.styleNameList.add("dark-label");
			sender.wordWrap = true;
			sender.text = "Travis";
			sender.x = closing.x;
			sender.y = closing.y + closing.height;
			sender.addEventListener(TouchEvent.TOUCH, onSenderTouch);
			addChild(sender);
			
			
			var centre:Quad = new Quad(width * 0.001, height * 0.475, 0x000000);
			centre.x = width * 0.5;
			centre.y = greeting.y + greeting.height;
			addChild(centre);
			
			
			address = new Label();
			address.styleNameList.add("dark-label");
			address.wordWrap = true;
			address.text = "Walter Lee Younger\n406 Clybourne Street\nClybourne Park, IL 62865";
			address.x = width * 0.55;
			address.y = body.y;
			address.width = width * 0.40;
			address.addEventListener(TouchEvent.TOUCH, onAddressTouch);
			addChild(address);
			
			var texture:Texture = AssetsManager.getStamps()[0];
			var image:Image = new Image(texture);
			image.width = Utils.Utilities.GetScaledX(0.08);
			image.scaleY = image.scaleX;
			image.alignPivot();
			addChild( image );
			image.x = width- (image.width*0.5) - Utilities.GetScaledX(0.02);
			image.y = Utilities.GetScaledY(0.03) + (image.height * 0.5);
			
			
		}
		
		private function onSenderTouch(e:TouchEvent):void 
		{
			if (e.getTouch(sender, TouchPhase.ENDED))
			{
				var label:Label = new Label();
				label.text = "Sender's Name\nThe signature or name of the person who is sending the postcard.";
				label.wordWrap = true;
				label.width = Utils.Utilities.GetScaledX(0.25);
				Callout.show( label, sender, Callout.DIRECTION_RIGHT );
			}
		}
		
		private function onClosingTouch(e:TouchEvent):void 
		{
			if (e.getTouch(closing, TouchPhase.ENDED))
			{
				var label:Label = new Label();
				label.text = "Closing\nThe closing provides a last word or two to the reader at the end of the message.";
				label.wordWrap = true;
				label.width = Utils.Utilities.GetScaledX(0.25);
				Callout.show( label, closing, Callout.DIRECTION_RIGHT );
			}
		}
		
		private function onAddressTouch(e:TouchEvent):void 
		{
			if (e.getTouch(address, TouchPhase.ENDED))
			{
				var label:Label = new Label();
				label.text = "Mailing Address\nThe name and address of the person or people who will receive the postcard.";
				label.wordWrap = true;
				label.width = Utils.Utilities.GetScaledX(0.25);
				Callout.show( label, address, Callout.DIRECTION_LEFT );
			}
		}
		
		private function onBodyTouch(e:TouchEvent):void 
		{
			if (e.getTouch(body, TouchPhase.ENDED))
			{
				var label:Label = new Label();
				label.text = "Body\nThe message included on the postcard.  The body is usually several sentences long.";
				label.wordWrap = true;
				label.width = Utils.Utilities.GetScaledX(0.25);
				Callout.show( label, body, Callout.DIRECTION_RIGHT );
			}
		}
		
		private function onGreetingTouch(e:TouchEvent):void 
		{
			if (e.getTouch(greeting, TouchPhase.ENDED))
			{
				var label:Label = new Label();
				label.text = "Greeting\nThe opening, which includes the name of the person who receives the message.";
				label.wordWrap = true;
				label.width = Utils.Utilities.GetScaledX(0.25);
				Callout.show( label, greeting, Callout.DIRECTION_RIGHT );
			}
		}
		
		private function onDescriptionTouch(e:TouchEvent):void 
		{
			if (e.getTouch(description, TouchPhase.ENDED))
			{
				var label:Label = new Label();
				label.text = "Postcard Description\nThe description of the scene or images that you will create for the front of the postcard.";
				label.wordWrap = true;
				label.width = Utils.Utilities.GetScaledX(0.25);
				Callout.show( label, description, Callout.DIRECTION_RIGHT );
			}
			
		}
	}
}
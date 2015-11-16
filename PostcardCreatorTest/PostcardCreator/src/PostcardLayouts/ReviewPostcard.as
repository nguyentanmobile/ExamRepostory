package PostcardLayouts 
{
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.Screen;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.PixelSnapping;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import Utils.AssetsManager;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import StoredObject.SharedObjectManager;
	import Utils.Utilities;
	
	/**
	 * ...
	 * @author Andrew Jarman
	 */
	public class ReviewPostcard extends Screen 
	{
		
		private var description:Label;
		private var greeting:Label;
		private var body:Label;
		private var address:Label;
		private var closing:Label;
		private var sender:Label;
		private var title:Label;
		private var credit:Label
		private var loader:Loader;
		private var image:Image;
		
		
		public function ReviewPostcard(width:Number, height:Number) 
		{
			super();
			
			this.width = width;
			this.height = height;
			
			var outerBackground:Quad = new Quad(width, height, 0xffffff)
			addChild(outerBackground);
			
			var top:Image = new Image(AssetsManager.getAtlas().getTexture("PCC_LetterTopBar"));
			addChild(top);
			top.alignPivot();
			top.width = width*0.988;
			top.scaleY = top.scaleX;
			top.x = width * 0.5;
			top.y = top.height;
			
			var bottom:Image = new Image(AssetsManager.getAtlas().getTexture("PCC_LetterTopBar"));
			addChild(bottom);
			bottom.alignPivot();
			bottom.width = width*0.988;
			bottom.scaleY = bottom.scaleX;
			bottom.x = width * 0.5;
			bottom.y = height - bottom.height;
			
			var left:Image = new Image(AssetsManager.getAtlas().getTexture("PCC_LetterLeftBar"));
			addChild(left);
			left.alignPivot();
			left.height = height*0.968;
			left.scaleX = left.scaleY;
			left.x = left.width
			left.y = height * 0.5;
			
			var right:Image = new Image(AssetsManager.getAtlas().getTexture("PCC_LetterLeftBar"));
			addChild(right);
			right.alignPivot();
			right.height = height * 0.968;
			right.scaleX = right.scaleY;
			right.x = width - left.width;
			right.y = height * 0.5;
			
			
			title = new Label();			
			title.styleNameList.add("dark-label");
			title.text = SharedObjectManager.getCurrentProject().imageTitle;
			addChild(title);
			title.x = width * 0.025;
			title.y = width * 0.025;
			title.validate();
			
			description = new Label();			
			description.styleNameList.add("dark-label");
			description.text = SharedObjectManager.getCurrentProject().imageDescription;
			addChild(description);
			description.x = title.x;
			description.y = title.y + title.height;
			description.validate();
			
			credit = new Label();			
			credit.styleNameList.add("dark-label");
			credit.text = SharedObjectManager.getCurrentProject().imageCredit;
			addChild(credit);
			credit.x = description.x;
			credit.y = description.y + description.height;
			credit.validate();
			
			greeting = new Label();
			greeting.styleNameList.add("dark-label");
			greeting.text = SharedObjectManager.getCurrentProject().greeting;
			greeting.x = credit.x;
			greeting.y = credit.y + credit.height + Utils.Utilities.GetScaledX(0.025);
			addChild(greeting);
			greeting.validate();
			
			body = new Label();
			body.styleNameList.add("dark-label");
			body.wordWrap = true;
			body.text = SharedObjectManager.getCurrentProject().body;
			body.x = greeting.x;
			body.y = greeting.y + (greeting.height * 1.5);
			body.width = width * 0.40;
			addChild(body);
			body.validate();
			
			var centre:Quad = new Quad(width * 0.001, height * 0.475, 0x000000);
			centre.x = width * 0.5;
			centre.y = greeting.y + greeting.height;
			addChild(centre);
			
			closing = new Label();
			closing.styleNameList.add("dark-label");
			closing.wordWrap = true;
			closing.text = SharedObjectManager.getCurrentProject().closing;
			closing.x = width * 0.35;
			closing.y = body.y + body.height;
			addChild(closing);
			closing.validate();
			
			
			sender = new Label();
			sender.styleNameList.add("dark-label");
			sender.wordWrap = true;
			sender.text = SharedObjectManager.getCurrentProject().sendersName;
			sender.x = closing.x;
			sender.y = closing.y + closing.height;
			addChild(sender);
			
			
			
			address = new Label();
			address.styleNameList.add("dark-label");
			address.wordWrap = true;
			address.text = SharedObjectManager.getCurrentProject().mailingAddress;
			address.x = width * 0.55;
			address.y = body.y;
			address.width = width * 0.40;
			addChild(address);
			
			
			var stampNum:int = SharedObjectManager.getCurrentProject().stamp;
			
			if (stampNum >= 0) {
				var texture:Texture= AssetsManager.getStamps()[stampNum];
				image = new Image(texture);
				image.width = Utils.Utilities.GetScaledX(0.08);
				image.scaleY = image.scaleX;
				image.alignPivot();
				addChild( image );
				image.x = width- (image.width*0.5) - Utilities.GetScaledX(0.02);
				image.y = Utilities.GetScaledY(0.03) + (image.height * 0.5);
				image.addEventListener(TouchEvent.TOUCH, onStampTouch);
			}
			else
			{
				try{
					var stampimageData:ByteArray = SharedObjectManager.getCurrentProject().stampimageData;
					if (stampimageData != null)
					{
						
						var rect:Rectangle = new Rectangle(0,0, SharedObjectManager.getCurrentProject().stampimagerect.width,
																SharedObjectManager.getCurrentProject().stampimagerect.height);
						
						var bitmapData:BitmapData = new BitmapData(rect.width, rect.height);
						stampimageData.position = 0;
						bitmapData.setPixels(rect, stampimageData);
						
						var bitmap:Bitmap = new Bitmap(bitmapData);
						var _texture:Texture = Texture.fromBitmap(bitmap);
						image = new Image(_texture);
						image.scaleY = image.scaleX = Math.min(Utils.Utilities.GetScaledX(0.1) / image.width, Utils.Utilities.GetScaledY(0.1) / image.height)
						image.alignPivot();
						image.x = width- (image.width*0.5) - Utilities.GetScaledX(0.02);
						image.y = Utilities.GetScaledY(0.03) + (image.height*0.5);
						addChild(image);
						
						image.addEventListener(TouchEvent.TOUCH, onStampTouch);
					}
				}
				catch (e:Error)
				{
					description.text = e.message;
				}
			}
		}
		
		private function onStampTouch(e:TouchEvent):void 
		{
			if (e.getTouch(image, TouchPhase.ENDED))
			{
				
				if (image.rotation == 0)
				{
					
					image.rotation = 1.570796;
					//image.x = width- (image.width*0.5) - Utilities.GetScaledX(-0.18);
					image.y = Utilities.GetScaledY(0.03) + (image.height*0.5);
					
				}
				else if (image.rotation == 1.570796)
				{
					
					image.rotation = 3.1415;
					//image.x = width- (image.width*0.5) - Utilities.GetScaledX(0.02);
					image.y = Utilities.GetScaledY(0.03) + (image.height*0.5);
				}
				else if (image.rotation == 3.1415)
				{
					
					image.rotation = -1.570796;
					//image.x = width- (image.width*0.5) - Utilities.GetScaledX(0.02);
					image.y = Utilities.GetScaledY(0.03) + (image.height*0.5);
				}
				else
				{
					image.rotation = 0;
					//image.x = width- (image.width*0.5) - Utilities.GetScaledX(0.02);
					image.y = Utilities.GetScaledY(0.03) + (image.height*0.5);
					
				}
			}
		}
		
		private function onError(e:ErrorEvent):void 
		{
			
		}
	}
}
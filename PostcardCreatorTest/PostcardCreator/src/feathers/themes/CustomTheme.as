package feathers.themes 
{
	/**
	 * ...
	 * @author Andrew Jarman
	 */
	
	import feathers.controls.Button;
	import feathers.controls.GroupedList;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Panel;
	import feathers.controls.renderers.BaseDefaultItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.ScrollContainer;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.controls.TextInput;
	import feathers.controls.ToggleButton;
	import feathers.core.ITextRenderer;
	import feathers.display.Scale9Image;
	import feathers.display.TiledImage;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.skins.SmartDisplayObjectStateValueSelector;
	import feathers.skins.StandardIcons;
	import feathers.system.DeviceCapabilities;
	import feathers.textures.Scale3Textures;
	import feathers.textures.Scale9Textures;
	import feathers.themes.MetalWorksMobileTheme;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontPosture;
	import flash.text.engine.FontWeight;
	import flash.text.engine.RenderingMode;
	import flash.text.TextFormat;
	import starling.display.DisplayObject;
	import flash.geom.Rectangle;
	import flash.text.engine.ElementFormat;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class CustomTheme extends MetalWorksMobileTheme
	{
		private var RALEWAY_regularFontDescription:FontDescription;
		private var RALEWAY_boldFontDescription:FontDescription;
		[Embed(source="../assets/fonts/Raleway-Black.ttf",fontFamily="Raleway",fontWeight="normal",mimeType="application/x-font",embedAsCFF="true")]
		protected static const RALEWAY_REGULAR:Class;
		
		[Embed(source="../assets/fonts/Raleway-Bold.ttf",fontFamily="Raleway",fontWeight="bold",mimeType="application/x-font",embedAsCFF="true")]
		protected static const RALEWAY_BOLD:Class;
		
		public static const RALEWAY_FONT_NAME:String = "Raleway";
		
		protected static const PRIMARY_BACKGROUND_COLOR:uint = 0x6498a3;
		protected static const LIGHT_TEXT_COLOR:uint = 0xe5e5e5;
		protected static const DARK_TEXT_COLOR:uint = 0x1a1816;
		protected static const INFO_TEXT_COLOR:uint = 0x0F4B56;
		
		protected static const SELECTED_TEXT_COLOR:uint = 0xff9900;
		protected static const DISABLED_TEXT_COLOR:uint = 0x8a8a8a;
		protected static const DARK_DISABLED_TEXT_COLOR:uint = 0x383430;
		protected static const LIST_BACKGROUND_COLOR:uint = 0x6498a3;
		protected static const TAB_BACKGROUND_COLOR:uint = 0x1a1816;
		protected static const TAB_DISABLED_BACKGROUND_COLOR:uint = 0x292624;
		protected static const GROUPED_LIST_HEADER_BACKGROUND_COLOR:uint = 0x2e2a26;
		protected static const GROUPED_LIST_FOOTER_BACKGROUND_COLOR:uint = 0x2e2a26;
		protected static const MODAL_OVERLAY_COLOR:uint = 0x29241e;
		protected static const MODAL_OVERLAY_ALPHA:Number = 0.8;
		protected static const DRAWER_OVERLAY_COLOR:uint = 0xffffff;
		protected static const DRAWER_OVERLAY_ALPHA:Number = 0.4;
		
		protected static const DEFAULT_SCALE9_GRID:Rectangle = new Rectangle(5, 5, 22, 22);
		protected static const BUTTON_SCALE9_GRID:Rectangle = new Rectangle(10, 10, 40, 40);
		protected static const BUTTON_SELECTED_SCALE9_GRID:Rectangle = new Rectangle(8, 8, 44, 44);
		protected static const BACK_BUTTON_SCALE3_REGION1:Number = 24;
		protected static const BACK_BUTTON_SCALE3_REGION2:Number = 6;
		protected static const FORWARD_BUTTON_SCALE3_REGION1:Number = 6;
		protected static const FORWARD_BUTTON_SCALE3_REGION2:Number = 6;
		protected static const ITEM_RENDERER_SCALE9_GRID:Rectangle = new Rectangle(3, 0, 2, 82);
		protected static const INSET_ITEM_RENDERER_FIRST_SCALE9_GRID:Rectangle = new Rectangle(13, 13, 3, 70);
		protected static const INSET_ITEM_RENDERER_LAST_SCALE9_GRID:Rectangle = new Rectangle(13, 0, 3, 75);
		protected static const INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID:Rectangle = new Rectangle(13, 13, 3, 62);
		protected static const TAB_SCALE9_GRID:Rectangle = new Rectangle(19, 19, 50, 50);
		protected static const SPINNER_LIST_SELECTION_OVERLAY_SCALE9_GRID:Rectangle = new Rectangle(3, 9, 1, 70);
		protected static const SCROLL_BAR_THUMB_REGION1:int = 5;
		protected static const SCROLL_BAR_THUMB_REGION2:int = 14;
		
		protected var splashFontSize:int;
		
		
		protected override function initializeScale():void
		{
			var scaledDPI:int = DeviceCapabilities.dpi / Starling.contentScaleFactor;
			this._originalDPI = scaledDPI;
			if(this._scaleToDPI)
			{
				this._originalDPI = ORIGINAL_DPI_IPAD_RETINA;
				
			}
			this.scale = scaledDPI / this._originalDPI;
		}
		
		protected override function initializeStage():void
		{
			Starling.current.stage.color = PRIMARY_BACKGROUND_COLOR;
			Starling.current.nativeStage.color = PRIMARY_BACKGROUND_COLOR;
			
			RALEWAY_regularFontDescription = new FontDescription(FONT_NAME, FontWeight.NORMAL, FontPosture.NORMAL, FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE);
			RALEWAY_boldFontDescription = new FontDescription(FONT_NAME, FontWeight.BOLD, FontPosture.NORMAL, FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE);
		}
		
		protected override function setListStyles(list:List):void
		{
			this.setScrollerStyles(list);
			var backgroundSkin:Quad = new Quad(this.gridSize, this.gridSize, LIST_BACKGROUND_COLOR);
			list.backgroundSkin = backgroundSkin;
		}
		
		public function CustomTheme(scaleToDPI:Boolean = true ) 
		{
			super(scaleToDPI);
		}
		
		protected function setCustomLabelStyles( label:Label ):void
		{
			
			label.textRendererProperties.elementFormat = new ElementFormat(this.regularFontDescription, this.regularFontSize, INFO_TEXT_COLOR);
			label.textRendererProperties.disabledElementFormat = this.disabledElementFormat;
			
		}
		
		protected function setInfoLabelStyles( label:Label ):void
		{
			

			//label.textRendererProperties.elementFormat = new ElementFormat(this.regularFontDescription, this.regularFontSize, INFO_TEXT_COLOR);
			//label.textRendererProperties.disabledElementFormat = this.disabledElementFormat;
			label.textRendererFactory = function():ITextRenderer
			{
				var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
				textRenderer.textFormat = new TextFormat( RALEWAY_FONT_NAME, regularFontSize, INFO_TEXT_COLOR );
				textRenderer.isHTML = true;
				return textRenderer;
			}
			
		}
		
		protected function setTitleLabelStyles( label:Label ):void
		{
			

			label.textRendererProperties.elementFormat = new ElementFormat(this.boldFontDescription, splashFontSize, DARK_TEXT_COLOR);
			label.textRendererProperties.disabledElementFormat = this.disabledElementFormat;
			
		}
		
		override protected function initializeStyleProviders():void
		{
			super.initializeStyleProviders(); // don't forget this!
		 
			this.getStyleProviderForClass( Label )
				.setFunctionForStyleName( "dark-label", this.setCustomLabelStyles );
				
			this.getStyleProviderForClass( Button )
				.setFunctionForStyleName( "Menu" , this.setMenuButtonStyle);
				
			this.getStyleProviderForClass( Button )
				.setFunctionForStyleName( "Info" , this.setInfoButtonStyle);
				
			this.getStyleProviderForClass( Button )
				.setFunctionForStyleName( "Next" , this.setNextButtonStyle);
			
				this.getStyleProviderForClass( Button )
				.setFunctionForStyleName( "Back" , this.setBackButtonStyle);
				
			this.getStyleProviderForClass( Button )
				.setFunctionForStyleName( "NewAccount" , this.setNewAccountButtonStyle);
				
			this.getStyleProviderForClass( Button )
				.setFunctionForStyleName( "NewProject" , this.setNewProjectButtonStyle);
				
			this.getStyleProviderForClass( Button )
				.setFunctionForStyleName( "TrashCan" , this.setTrashButtonStyle);
				
			this.getStyleProviderForClass( Header )
				.setFunctionForStyleName( "Header" , this.setHeaderStyle);
				
			this.getStyleProviderForClass( Panel )
				.setFunctionForStyleName( "Popup" , this.setPopUpStyles);
				
			this.getStyleProviderForClass( ScrollContainer )
				.setFunctionForStyleName( "infoContainer" , this.setInfoScrollContainerStyles);
				
			this.getStyleProviderForClass( Label )
				.setFunctionForStyleName( "infoLabel", this.setInfoLabelStyles );
				
			this.getStyleProviderForClass( Label )
				.setFunctionForStyleName( "Title", this.setTitleLabelStyles );
				
			this.getStyleProviderForClass( TextInput )
				.setFunctionForStyleName( "PopupInput", this.setPopUpTextInputStyles );
			
			this.getStyleProviderForClass( DefaultListItemRenderer )
				.setFunctionForStyleName( "AccountList", this.setAccountListRendererStyles );
				
			this.getStyleProviderForClass( DefaultListItemRenderer )
				.setFunctionForStyleName( "ProjectList", this.setProjectListRendererStyles );
		}
		protected function setNewAccountButtonStyle(button:Button):void
		{
			setButtonStyles(button);
			button.defaultIcon = new Image(atlas.getTexture("PCC_NewAccountIcon"));
			button.defaultIcon.scaleX = button.defaultIcon.scaleY = this.scale;
			button.iconPosition = Button.ICON_POSITION_LEFT;
			
		}
		
		protected function setNewProjectButtonStyle(button:Button):void
		{
			setButtonStyles(button);
			button.defaultIcon = new Image(atlas.getTexture("PCC_NewPostcardIcon"));
			button.defaultIcon.scaleX = button.defaultIcon.scaleY = this.scale;
			button.iconPosition = Button.ICON_POSITION_LEFT;
			
		}
		
		protected function setPopUpTextInputStyles(input:TextInput):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = new Scale9Textures(atlas.getTexture("background-disabled-skin2"), new Rectangle(11, 11, 10, 10));
			skinSelector.setValueForState(new Scale9Textures(atlas.getTexture("background-disabled-skin2"), new Rectangle(11, 11, 10, 10)), TextInput.STATE_DISABLED);
			skinSelector.setValueForState(new Scale9Textures(atlas.getTexture("background-disabled-skin2"), new Rectangle(11, 11, 10, 10)), TextInput.STATE_FOCUSED);
			skinSelector.displayObjectProperties =
			{
				width: this.wideControlSize,
				height: this.controlSize,
				textureScale: this.scale
			};
			input.stateToSkinFunction = skinSelector.updateValue;

			input.minWidth = this.controlSize;
			input.minHeight = this.controlSize;
			input.minTouchWidth = this.gridSize;
			input.minTouchHeight = this.gridSize;
			input.gap = this.smallGutterSize;
			input.padding = this.smallGutterSize;

			input.textEditorProperties.fontFamily = "Helvetica";
			input.textEditorProperties.fontSize = this.regularFontSize;
			input.textEditorProperties.color = DARK_TEXT_COLOR;
			input.textEditorProperties.disabledColor = DISABLED_TEXT_COLOR;

			input.promptProperties.elementFormat = this.lightElementFormat;
			input.promptProperties.disabledElementFormat = this.disabledElementFormat;
		}
		
		protected function setInfoScrollContainerStyles(container:ScrollContainer):void
		{
			this.setScrollerStyles(container);
			if(!container.layout)
			{
				var layout:VerticalLayout = new VerticalLayout();
				layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER
				layout.padding = this.smallGutterSize;
				layout.gap = this.smallGutterSize;
				container.layout = layout;
			}
			container.minWidth = this.gridSize;
			container.minHeight = this.gridSize;

			var backgroundSkin:Scale9Image = new Scale9Image(new Scale9Textures(atlas.getTexture("PCC_TipsBox"), new Rectangle(10, 10, 40, 40)), this.scale);
			backgroundSkin.width = backgroundSkin.height = this.gridSize;
			container.backgroundSkin = backgroundSkin;
		}
		
		
		protected function setPopUpStyles(panel:Panel):void
		{
			this.setScrollerStyles(panel);

			panel.backgroundSkin = new Scale9Image(new Scale9Textures(atlas.getTexture("PCC_PopUpWindow"), new Rectangle(22, 22, 40, 40)), this.scale);
			
			panel.paddingTop = 0;
			panel.paddingRight = this.smallGutterSize;
			panel.paddingBottom = this.smallGutterSize;
			panel.paddingLeft = this.smallGutterSize;
		}
		
		protected function setNextButtonStyle(button:Button):void
		{
			setButtonStyles(button);
			var img:Image = new Image(atlas.getTexture("PCC_Arrow"));
			img.scaleX = img.scaleY = this.scale;
			button.defaultIcon = img;
			button.iconPosition = Button.ICON_POSITION_RIGHT;
			button.iconOffsetY = -2
		}
		
		protected function setBackButtonStyle(button:Button):void
		{
			setButtonStyles(button);
			var img:Image = new Image(atlas.getTexture("PCC_RArrow"));
			img.scaleX = img.scaleY = this.scale;
			button.defaultIcon = img;
			button.iconPosition = Button.ICON_POSITION_LEFT;
			button.iconOffsetY = -2
		}
		
		protected function setInfoButtonStyle(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			if(button is ToggleButton)
			{
				//for convenience, this function can style both a regular button
				//and a toggle button
				skinSelector.defaultSelectedValue = this.buttonSelectedUpSkinTextures;
				skinSelector.setValueForState(this.buttonSelectedDisabledSkinTextures, Button.STATE_DISABLED, true);
			}
			skinSelector.displayObjectProperties =
			{
				width: this.controlSize,
				height: this.controlSize,
				textureScale: this.scale
			};
			button.defaultIcon = new Image(atlas.getTexture("PCC_InfoIcon"));
			button.defaultIcon.scaleX = button.defaultIcon.scaleY = this.scale;
			this.setBaseButtonStyles(button);
		}
		
		protected function setTrashButtonStyle(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector()
			skinSelector.displayObjectProperties =
			{
				width: this.controlSize,
				height: this.controlSize,
				textureScale: this.scale
			};
			button.defaultIcon = new Image(atlas.getTexture("TrashCan"));
			button.defaultIcon.scaleX = button.defaultIcon.scaleY = this.scale;
			this.setBaseButtonStyles(button);
		}
	
		protected function setMenuButtonStyle(button:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			if(button is ToggleButton)
			{
				//for convenience, this function can style both a regular button
				//and a toggle button
				skinSelector.defaultSelectedValue = this.buttonSelectedUpSkinTextures;
				skinSelector.setValueForState(this.buttonSelectedDisabledSkinTextures, Button.STATE_DISABLED, true);
			}
			skinSelector.displayObjectProperties =
			{
				width: this.controlSize,
				height: this.controlSize,
				textureScale: this.scale
			};
			button.defaultIcon = new Image(atlas.getTexture("PCC_MenuIcon"));
			button.defaultIcon.scaleX = button.defaultIcon.scaleY = this.scale;
			this.setBaseButtonStyles(button);
		}
		
		protected function setHeaderStyle(header:Header):void
		{
			header.minWidth = 0;
			header.minHeight = 0;
			header.padding = 0;
			header.gap = 0;
			header.titleGap = 0;

			var backgroundSkin:TiledImage = new TiledImage(this.headerBackgroundSkinTexture, 1);
			backgroundSkin.width = 0;
			backgroundSkin.height = 0;
			header.backgroundSkin = backgroundSkin;
			header.titleProperties.elementFormat = new ElementFormat(RALEWAY_boldFontDescription, this.extraLargeFontSize, INFO_TEXT_COLOR);
		}
		
		protected override function initializeTextures():void
		{
			
			var backgroundSkinTexture:Texture = this.atlas.getTexture("background-skin");
			var backgroundInsetSkinTexture:Texture = this.atlas.getTexture("background-inset-skin");
			var backgroundDownSkinTexture:Texture = this.atlas.getTexture("background-down-skin");
			var backgroundDisabledSkinTexture:Texture = this.atlas.getTexture("background-disabled-skin");
			var backgroundFocusedSkinTexture:Texture = this.atlas.getTexture("background-focused-skin");
			var backgroundPopUpSkinTexture:Texture = this.atlas.getTexture("background-popup-skin");

			this.backgroundSkinTextures = new Scale9Textures(backgroundSkinTexture, DEFAULT_SCALE9_GRID);
			this.backgroundInsetSkinTextures = new Scale9Textures(backgroundInsetSkinTexture, DEFAULT_SCALE9_GRID);
			this.backgroundDisabledSkinTextures = new Scale9Textures(backgroundDisabledSkinTexture, DEFAULT_SCALE9_GRID);
			this.backgroundFocusedSkinTextures = new Scale9Textures(backgroundFocusedSkinTexture, DEFAULT_SCALE9_GRID);
			this.backgroundPopUpSkinTextures = new Scale9Textures(backgroundPopUpSkinTexture, DEFAULT_SCALE9_GRID);

			this.buttonUpSkinTextures = new Scale9Textures(this.atlas.getTexture("button-up-skin"), BUTTON_SCALE9_GRID);
			this.buttonDownSkinTextures = new Scale9Textures(this.atlas.getTexture("button-down-skin"), BUTTON_SCALE9_GRID);
			this.buttonDisabledSkinTextures = new Scale9Textures(this.atlas.getTexture("button-disabled-skin"), BUTTON_SCALE9_GRID);
			this.buttonSelectedUpSkinTextures = new Scale9Textures(this.atlas.getTexture("button-selected-up-skin"), BUTTON_SELECTED_SCALE9_GRID);
			this.buttonSelectedDisabledSkinTextures = new Scale9Textures(this.atlas.getTexture("button-selected-disabled-skin"), BUTTON_SELECTED_SCALE9_GRID);
			this.buttonCallToActionUpSkinTextures = new Scale9Textures(this.atlas.getTexture("button-call-to-action-up-skin"), BUTTON_SCALE9_GRID);
			this.buttonCallToActionDownSkinTextures = new Scale9Textures(this.atlas.getTexture("button-call-to-action-down-skin"), BUTTON_SCALE9_GRID);
			this.buttonDangerUpSkinTextures = new Scale9Textures(this.atlas.getTexture("button-danger-up-skin"), BUTTON_SCALE9_GRID);
			this.buttonDangerDownSkinTextures = new Scale9Textures(this.atlas.getTexture("button-danger-down-skin"), BUTTON_SCALE9_GRID);
			this.buttonBackUpSkinTextures = new Scale3Textures(this.atlas.getTexture("button-back-up-skin"), BACK_BUTTON_SCALE3_REGION1, BACK_BUTTON_SCALE3_REGION2);
			this.buttonBackDownSkinTextures = new Scale3Textures(this.atlas.getTexture("button-back-down-skin"), BACK_BUTTON_SCALE3_REGION1, BACK_BUTTON_SCALE3_REGION2);
			this.buttonBackDisabledSkinTextures = new Scale3Textures(this.atlas.getTexture("button-back-disabled-skin"), BACK_BUTTON_SCALE3_REGION1, BACK_BUTTON_SCALE3_REGION2);
			this.buttonForwardUpSkinTextures = new Scale3Textures(this.atlas.getTexture("button-forward-up-skin"), FORWARD_BUTTON_SCALE3_REGION1, FORWARD_BUTTON_SCALE3_REGION2);
			this.buttonForwardDownSkinTextures = new Scale3Textures(this.atlas.getTexture("button-forward-down-skin"), FORWARD_BUTTON_SCALE3_REGION1, FORWARD_BUTTON_SCALE3_REGION2);
			this.buttonForwardDisabledSkinTextures = new Scale3Textures(this.atlas.getTexture("button-forward-disabled-skin"), FORWARD_BUTTON_SCALE3_REGION1, FORWARD_BUTTON_SCALE3_REGION2);

			this.tabDownSkinTextures = new Scale9Textures(this.atlas.getTexture("tab-down-skin"), TAB_SCALE9_GRID);
			this.tabSelectedSkinTextures = new Scale9Textures(this.atlas.getTexture("tab-selected-skin"), TAB_SCALE9_GRID);
			this.tabSelectedDisabledSkinTextures = new Scale9Textures(this.atlas.getTexture("tab-selected-disabled-skin"), TAB_SCALE9_GRID);

			this.pickerListButtonIconTexture = this.atlas.getTexture("picker-list-icon");
			this.pickerListButtonIconDisabledTexture = this.atlas.getTexture("picker-list-icon-disabled");
			this.pickerListItemSelectedIconTexture = this.atlas.getTexture("picker-list-item-selected-icon");

			this.spinnerListSelectionOverlaySkinTextures = new Scale9Textures(this.atlas.getTexture("spinner-list-selection-overlay-skin"), SPINNER_LIST_SELECTION_OVERLAY_SCALE9_GRID);

			this.radioUpIconTexture = backgroundSkinTexture;
			this.radioDownIconTexture = backgroundDownSkinTexture;
			this.radioDisabledIconTexture = backgroundDisabledSkinTexture;
			this.radioSelectedUpIconTexture = this.atlas.getTexture("radio-selected-up-icon");
			this.radioSelectedDownIconTexture = this.atlas.getTexture("radio-selected-down-icon");
			this.radioSelectedDisabledIconTexture = this.atlas.getTexture("radio-selected-disabled-icon");

			this.checkUpIconTexture = backgroundSkinTexture;
			this.checkDownIconTexture = backgroundDownSkinTexture;
			this.checkDisabledIconTexture = backgroundDisabledSkinTexture;
			this.checkSelectedUpIconTexture = this.atlas.getTexture("check-selected-up-icon");
			this.checkSelectedDownIconTexture = this.atlas.getTexture("check-selected-down-icon");
			this.checkSelectedDisabledIconTexture = this.atlas.getTexture("check-selected-disabled-icon");

			this.pageIndicatorSelectedSkinTexture = this.atlas.getTexture("page-indicator-selected-skin");
			this.pageIndicatorNormalSkinTexture = this.atlas.getTexture("page-indicator-normal-skin");

			this.searchIconTexture = this.atlas.getTexture("search-icon");
			this.searchIconDisabledTexture = this.atlas.getTexture("search-icon-disabled");

			this.itemRendererUpSkinTextures = new Scale9Textures(this.atlas.getTexture("list-item-up-skin"), ITEM_RENDERER_SCALE9_GRID);
			this.itemRendererSelectedSkinTextures = new Scale9Textures(this.atlas.getTexture("list-item-selected-skin"), ITEM_RENDERER_SCALE9_GRID);
			this.insetItemRendererFirstUpSkinTextures = new Scale9Textures(this.atlas.getTexture("list-inset-item-first-up-skin"), INSET_ITEM_RENDERER_FIRST_SCALE9_GRID);
			this.insetItemRendererFirstSelectedSkinTextures = new Scale9Textures(this.atlas.getTexture("list-inset-item-first-selected-skin"), INSET_ITEM_RENDERER_FIRST_SCALE9_GRID);
			this.insetItemRendererLastUpSkinTextures = new Scale9Textures(this.atlas.getTexture("list-inset-item-last-up-skin"), INSET_ITEM_RENDERER_LAST_SCALE9_GRID);
			this.insetItemRendererLastSelectedSkinTextures = new Scale9Textures(this.atlas.getTexture("list-inset-item-last-selected-skin"), INSET_ITEM_RENDERER_LAST_SCALE9_GRID);
			this.insetItemRendererSingleUpSkinTextures = new Scale9Textures(this.atlas.getTexture("list-inset-item-single-up-skin"), INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID);
			this.insetItemRendererSingleSelectedSkinTextures = new Scale9Textures(this.atlas.getTexture("list-inset-item-single-selected-skin"), INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID);

			this.headerBackgroundSkinTexture = this.atlas.getTexture("header-background-skin");

			this.calloutTopArrowSkinTexture = this.atlas.getTexture("callout-arrow-top-skin");
			this.calloutRightArrowSkinTexture = this.atlas.getTexture("callout-arrow-right-skin");
			this.calloutBottomArrowSkinTexture = this.atlas.getTexture("callout-arrow-bottom-skin");
			this.calloutLeftArrowSkinTexture = this.atlas.getTexture("callout-arrow-left-skin");

			this.horizontalScrollBarThumbSkinTextures = new Scale3Textures(this.atlas.getTexture("horizontal-scroll-bar-thumb-skin"), SCROLL_BAR_THUMB_REGION1, SCROLL_BAR_THUMB_REGION2, Scale3Textures.DIRECTION_HORIZONTAL);
			this.verticalScrollBarThumbSkinTextures = new Scale3Textures(this.atlas.getTexture("vertical-scroll-bar-thumb-skin"), SCROLL_BAR_THUMB_REGION1, SCROLL_BAR_THUMB_REGION2, Scale3Textures.DIRECTION_VERTICAL);

			StandardIcons.listDrillDownAccessoryTexture = this.atlas.getTexture("list-accessory-drill-down-icon");
		}
		
		protected override function initializeFonts():void
		{
			this.smallFontSize = Math.round(16 * this.scale);
			this.regularFontSize = Math.round(18 * this.scale);
			this.largeFontSize = Math.round(20 * this.scale);
			this.extraLargeFontSize = Math.round(30 * this.scale);
			this.splashFontSize = Math.round(75 * this.scale);

			//these are for components that don't use FTE
			this.scrollTextTextFormat = new TextFormat("_sans", this.regularFontSize, LIGHT_TEXT_COLOR);
			this.scrollTextDisabledTextFormat = new TextFormat("_sans", this.regularFontSize, DISABLED_TEXT_COLOR);

			this.regularFontDescription = new FontDescription(FONT_NAME, FontWeight.NORMAL, FontPosture.NORMAL, FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE);
			this.boldFontDescription = new FontDescription(FONT_NAME, FontWeight.BOLD, FontPosture.NORMAL, FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE);

			this.headerElementFormat = new ElementFormat(this.boldFontDescription, this.extraLargeFontSize, DARK_TEXT_COLOR);

			this.darkUIElementFormat = new ElementFormat(this.boldFontDescription, this.regularFontSize, DARK_TEXT_COLOR);
			this.lightUIElementFormat = new ElementFormat(this.boldFontDescription, this.regularFontSize, LIGHT_TEXT_COLOR);
			this.selectedUIElementFormat = new ElementFormat(this.boldFontDescription, this.regularFontSize, SELECTED_TEXT_COLOR);
			this.lightUIDisabledElementFormat = new ElementFormat(this.boldFontDescription, this.regularFontSize, DISABLED_TEXT_COLOR);
			this.darkUIDisabledElementFormat = new ElementFormat(this.boldFontDescription, this.regularFontSize, DARK_DISABLED_TEXT_COLOR);

			this.largeUIDarkElementFormat = new ElementFormat(this.boldFontDescription, this.largeFontSize, DARK_TEXT_COLOR);
			this.largeUILightElementFormat = new ElementFormat(this.boldFontDescription, this.largeFontSize, LIGHT_TEXT_COLOR);
			this.largeUISelectedElementFormat = new ElementFormat(this.boldFontDescription, this.largeFontSize, SELECTED_TEXT_COLOR);
			this.largeUIDarkDisabledElementFormat = new ElementFormat(this.boldFontDescription, this.largeFontSize, DARK_DISABLED_TEXT_COLOR);
			this.largeUILightDisabledElementFormat = new ElementFormat(this.boldFontDescription, this.largeFontSize, DISABLED_TEXT_COLOR);

			this.darkElementFormat = new ElementFormat(this.regularFontDescription, this.regularFontSize, DARK_TEXT_COLOR);
			this.lightElementFormat = new ElementFormat(this.regularFontDescription, this.regularFontSize, LIGHT_TEXT_COLOR);
			this.disabledElementFormat = new ElementFormat(this.regularFontDescription, this.regularFontSize, DISABLED_TEXT_COLOR);

			this.smallLightElementFormat = new ElementFormat(this.regularFontDescription, this.smallFontSize, LIGHT_TEXT_COLOR);
			this.smallDisabledElementFormat = new ElementFormat(this.regularFontDescription, this.smallFontSize, DISABLED_TEXT_COLOR);

			this.largeDarkElementFormat = new ElementFormat(this.regularFontDescription, this.largeFontSize, DARK_TEXT_COLOR);
			this.largeLightElementFormat = new ElementFormat(this.regularFontDescription, this.largeFontSize, LIGHT_TEXT_COLOR);
			this.largeDisabledElementFormat = new ElementFormat(this.regularFontDescription, this.largeFontSize, DISABLED_TEXT_COLOR);
		}
		
		protected function setAccountListRendererStyles(renderer:BaseDefaultItemRenderer):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.itemRendererUpSkinTextures;
			skinSelector.defaultSelectedValue = this.itemRendererSelectedSkinTextures;
			skinSelector.setValueForState(this.itemRendererSelectedSkinTextures, Button.STATE_DOWN, false);
			skinSelector.displayObjectProperties =
			{
				width: this.gridSize,
				height: this.gridSize,
				textureScale: this.scale
			};
			renderer.stateToSkinFunction = skinSelector.updateValue;

			renderer.defaultLabelProperties.elementFormat = new ElementFormat(RALEWAY_regularFontDescription, this.largeFontSize, LIGHT_TEXT_COLOR);
			renderer.downLabelProperties.elementFormat = this.largeDarkElementFormat;
			renderer.defaultSelectedLabelProperties.elementFormat = this.largeDarkElementFormat;
			renderer.disabledLabelProperties.elementFormat = this.largeDisabledElementFormat;

			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
			renderer.paddingTop = this.smallGutterSize;
			renderer.paddingBottom = this.smallGutterSize;
			renderer.paddingLeft = this.gutterSize;
			renderer.paddingRight = this.gutterSize;
			renderer.gap = this.gutterSize;
			renderer.minGap = this.gutterSize;
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.minAccessoryGap = this.gutterSize;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.minWidth = this.gridSize;
			renderer.minHeight = this.gridSize;
			renderer.minTouchWidth = this.gridSize;
			renderer.minTouchHeight = this.gridSize;

			renderer.accessoryLoaderFactory = this.imageLoaderFactory;
			renderer.iconLoaderFactory = this.imageLoaderFactory;
			renderer.iconSourceFunction = getTexture;
			function getTexture():Texture
			{
				return atlas.getTexture("PCC_AccountIcon");
			}
		}
		
		protected function setProjectListRendererStyles(renderer:BaseDefaultItemRenderer):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.itemRendererUpSkinTextures;
			skinSelector.defaultSelectedValue = this.itemRendererSelectedSkinTextures;
			skinSelector.setValueForState(this.itemRendererSelectedSkinTextures, Button.STATE_DOWN, false);
			skinSelector.displayObjectProperties =
			{
				width: this.gridSize,
				height: this.gridSize,
				textureScale: this.scale
			};
			renderer.stateToSkinFunction = skinSelector.updateValue;

			
			renderer.defaultLabelProperties.elementFormat = new ElementFormat(RALEWAY_regularFontDescription, this.largeFontSize, LIGHT_TEXT_COLOR);
			renderer.downLabelProperties.elementFormat = this.largeDarkElementFormat;
			renderer.defaultSelectedLabelProperties.elementFormat = this.largeDarkElementFormat;
			renderer.disabledLabelProperties.elementFormat = this.largeDisabledElementFormat;

			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
			renderer.paddingTop = this.smallGutterSize;
			renderer.paddingBottom = this.smallGutterSize;
			renderer.paddingLeft = this.gutterSize;
			renderer.paddingRight = this.gutterSize;
			renderer.gap = this.gutterSize;
			renderer.minGap = this.gutterSize;
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.minAccessoryGap = this.gutterSize;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.minWidth = this.gridSize;
			renderer.minHeight = this.gridSize;
			renderer.minTouchWidth = this.gridSize;
			renderer.minTouchHeight = this.gridSize;

			renderer.accessoryLoaderFactory = this.imageLoaderFactory;
			renderer.iconLoaderFactory = this.imageLoaderFactory;
			renderer.iconSourceFunction = getTexture;
			function getTexture():Texture
			{
				return atlas.getTexture("PCC_PostcardIcon");
			}
		}
		
	}
	


}
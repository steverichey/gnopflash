package
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	public class DropMenu extends Sprite
	{
		private var whiteBox:Bitmap;
		private var whiteBoxData:BitmapData;
		
		private var borderBox:Bitmap;
		private var borderBoxData:BitmapData;
		
		private var shadowBox:Bitmap;
		private var shadowBoxData:BitmapData;
		
		private var dividerLine:Bitmap;
		private var dividerLineData:BitmapData;
		
		private var greyTextArray:Array;
		
		public var contentList:Array;
		public var headerName:String; // Name of this menu's header.
		public var headerNumber:uint; // Number of this menu's header, starts at 0, goes left-right.
		private var textColor:uint;
		private var bgColor:uint;
		
		public var item0:MenuItem;
		public var item1:MenuItem;
		public var item2:MenuItem;
		public var item3:MenuItem;
		public var item4:MenuItem;
		public var item5:MenuItem;
		public var item6:MenuItem;
		public var item7:MenuItem;
		public var item8:MenuItem;
		public var item9:MenuItem;
		
		public var menuitemContainer:Array;
		
		public function DropMenu( contents:Array, name:String, hdrNum:uint = 0, txtClr:uint = 0x000000, bgClr:uint = 0xFFFFFF )
		{	
			this.contentList = contents;
			this.headerName = name;
			this.headerNumber = hdrNum;
			this.textColor = txtClr;
			this.bgColor = bgClr;
			
			if ( stage )
			{
				onAddtoStage();
			}
			else
			{
				addEventListener( Event.ADDED_TO_STAGE, onAddtoStage, false, 0, true );
			}
		}
		
		public function onAddtoStage( e:Event = null ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddtoStage );
			
			// Cycle through all of the items in the new drop menu, and get the width of the widest item for later use.
			
			var widestText:uint = 0;
			
			for ( var o:uint = 0; o <= contentList.length - 1; o++ )
			{
				var tempField:TextField = new TextField();
				tempField.embedFonts = true;
				tempField.defaultTextFormat = new TextFormat( "chicago", 12, 0x000000, null, null, null, null, null, "left" );
				tempField.gridFitType = GridFitType.PIXEL;
				tempField.antiAliasType = AntiAliasType.ADVANCED;
				tempField.thickness = 0;
				tempField.sharpness = 0;
				
				if ( contentList[o].substr( 0, 5 ) != "GREY_" )
				{
					tempField.text = contentList[o];
				}
				else
				{
					tempField.text = contentList[o].substr( 5, contentList[o].length - 5 );
				}
				
				if ( tempField.textWidth > widestText )
				{
					widestText = tempField.textWidth;
				}
			}
			
			var thisWidth:uint = widestText + 24;
			
			shadowBoxData = new BitmapData( thisWidth, contentList.length * 16, false, 0x000000 );
			shadowBox = new Bitmap( shadowBoxData, "auto", false );
			shadowBox.x = 3;
			shadowBox.y = 3;
			addChild( shadowBox );
			
			borderBoxData = new BitmapData( thisWidth + 2, contentList.length * 16 + 2, false, 0x000000 );
			borderBox = new Bitmap( borderBoxData, "auto", false );
			addChild( borderBox );
			
			whiteBoxData = new BitmapData( thisWidth, contentList.length * 16, false, bgColor );
			whiteBox = new Bitmap( whiteBoxData, "auto", false );
			whiteBox.x = 1;
			whiteBox.y = 1;
			addChild( whiteBox );
			
			menuitemContainer = new Array();
			greyTextArray = new Array();
			
			var selectableItemCounter:uint = 0;
			
			for ( var i:uint = 0; i <= contentList.length - 1; i++)
			{
				if ( contentList[i] == "LINE" )
				{
					dividerLineData = new BitmapData( thisWidth, 1, false, 0x878787 );
					dividerLine = new Bitmap( dividerLineData, "auto", false );
					dividerLine.x = 1;
					dividerLine.y = 9 + 16 * i;
					addChild( dividerLine );
				}
				else if ( contentList[i].substr( 0, 5 ) == "GREY_" )
				{
					var greyText:TextField = new TextField;
					greyText.embedFonts = true;
					greyText.defaultTextFormat = new TextFormat( "chicago", 12, 0x878787, null, null, null, null, null, "left" );
					greyText.gridFitType = GridFitType.PIXEL;
					greyText.antiAliasType = AntiAliasType.ADVANCED;
					greyText.thickness = 0;
					greyText.sharpness = 0;
					greyText.text = contentList[i].substr( 5, contentList[i].toString().length - 5 );
					greyText.x = 13;
					greyText.y = 16 * i - 1;
					greyText.width = thisWidth - 13;
					greyText.selectable = false;
					addChild( greyText );
					greyTextArray.push( greyText );
				}
				else
				{
					this["item"+i] = new MenuItem( contentList[i], thisWidth, false, headerNumber, selectableItemCounter, textColor, bgColor );
					this["item"+i].x = 1;
					this["item"+i].y = 16 * i;
					addChild( this["item" + i] );
					
					this["item" + i].itemNumber = i;
					menuitemContainer.push( this["item" + i] );
					
					selectableItemCounter++;
				}
			}
		}
	}
}
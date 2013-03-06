package
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	public class MenuItem extends Sprite
	{
		[Embed(source = "data/septagon.png")] private var SeptagonBitmap:Class;
		private var septagonBitmap:Bitmap = new SeptagonBitmap();
		
		[Embed(source = "data/checkmark.png")] public var CheckMark:Class;
		public var checkBitmap:Bitmap = new CheckMark();
		
		private var thisText:String;
		private var thisWidth:uint;
		private var isHeader:Boolean;
		public var headerNumber:uint;
		public var dropNumber:uint;
		private var textColor:uint;
		private var bgColor:uint;
		
		private var bgBitmap:Bitmap;
		private var bgBitmapData:BitmapData;
		private var textField:TextField;
		
		public var isInverted:Boolean;
		public var itemNumber:uint;
		
		public function MenuItem( passedTitle:String, passedWidth:uint, isHdr:Boolean=false, hdrNum:uint = 0, drpNum:uint = 0, txtClr:uint = 0x000000, bgClr:uint = 0xFFFFFF )
		{
			this.thisText = passedTitle;
			this.thisWidth = passedWidth;
			this.isHeader = isHdr;
			this.headerNumber = hdrNum;
			this.dropNumber = drpNum;
			this.textColor = txtClr;
			this.bgColor = bgClr;
			
			isInverted = false;
			
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
			
			var thisHeight:uint;
			var thisY:uint;
			var textX:uint;
			var textY:uint;
			var textWidth:uint = thisWidth;
			
			if ( isHeader )
			{
				thisHeight = 18;
				thisY = 0;
				textX = 10;
				textY = 4;
			}
			else
			{
				thisHeight = 16;
				thisY = 1;
				textX = 15;
				textY = 4;
			}
			
			bgBitmapData = new BitmapData( thisWidth, thisHeight, false, bgColor );
			bgBitmap = new Bitmap( bgBitmapData, "auto", false );
			bgBitmap.y = thisY;
			addChild( bgBitmap );
			
			if ( thisText.substr( 0, 4 ) == "TAB_" )
			{
				// Covers the special case of the small/normal/large options on the Paddles menu, which are tabbed in
				// 8px more than normal.
				
				thisText = thisText.substr( 4, thisText.length - 4 );
				textX += 8;
				textWidth -= 8;
			}
			
			if ( thisText != "SEPTAGON" )
			{
				textField = new TextField();
				textField.embedFonts = true;
				textField.defaultTextFormat = new TextFormat( "chicago", 12, textColor, null, null, null, null, null, "left" );
				textField.width = 200;
				textField.text = thisText;
				textField.gridFitType = GridFitType.PIXEL;
				textField.antiAliasType = AntiAliasType.ADVANCED;
				textField.thickness = 0;
				textField.sharpness = 0;
				
				// Due to some clipping issues (the letter g specifically) when the textfield was created, I decided
				// to convert the textfield to a bitmap. This also enables the use of threshold to get a bitmapped text effect.
				
				var textBitmapData:BitmapData = new BitmapData( textWidth - 15, thisHeight, true, 0x585657 );
				var textBitmapMatrix:Matrix = new Matrix( 1, 0, 0, 1, -3, -5 );
				textBitmapData.draw( textField, textBitmapMatrix );
				
				var textBitmap:Bitmap = new Bitmap( textBitmapData );
				textBitmap.x = textX;
				textBitmap.y = textY;
				
				addChild( textBitmap );
			}
			else
			{
				septagonBitmap.x = 8;
				septagonBitmap.y = 2;
				addChild( septagonBitmap );
			}
			
			if ( !isHeader )
			{
				checkBitmap.x = 3;
				checkBitmap.y = 4;
				checkBitmap.visible = false;
				addChild( checkBitmap );
			}
		}
		
		public function invertThis():void
		{
			// If this is the colored septagon, we don't want to invert the Septagon itself, just the background.
			
			if ( thisText == "SEPTAGON" )
			{
				bgBitmap.transform.colorTransform = new ColorTransform( -1, -1, -1, 1, 255, 255, 255 );
			}
			else
			{
				this.transform.colorTransform = new ColorTransform( -1, -1, -1, 1, 255, 255, 255 );
			}
			
			isInverted = true;
		}
		
		public function resetThis():void
		{
			if ( thisText == "SEPTAGON" )
			{
				bgBitmap.transform.colorTransform = new ColorTransform();
			}
			else
			{
				this.transform.colorTransform = new ColorTransform();
			}
			
			isInverted = false;
		}
	}
}
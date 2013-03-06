﻿package{	import flash.display.Sprite;	import flash.display.MovieClip;	import flash.events.Event;	import flash.display.Bitmap;	import flash.text.TextField;	import flash.text.TextFormat;	import flash.text.GridFitType;	import flash.text.AntiAliasType;		public class Popup extends MovieClip	{		private var okayButton:OkayButton;		private var cancelButton:CancelButton;		private var popup:Popup;				[Embed(source = "data/about.png")] public var AboutBitmap:Class;		private var aboutBitmap:Bitmap = new AboutBitmap();				[Embed(source = "data/instructions.png")] public var InstructionsBitmap:Class;		private var instructionsBitmap:Bitmap = new InstructionsBitmap();				[Embed(source = "data/setendscore.png")] public var SetEndScoreBitmap:Class;		private var setEndScoreBitmap:Bitmap = new SetEndScoreBitmap();				[Embed(source = "data/scorewarning.png")] public var ScoreWarningBitmap:Class;		private var scoreWarningBitmap:Bitmap = new ScoreWarningBitmap();				private var type:String;				private var scoreInput:TextField;		private var isSetEndScore:Boolean;		private var okayX:uint;		private var okayY:uint;		private var cancelX:uint;		private var cancelY:uint;				public function Popup( thisPopupType:String, okX:uint, okY:uint, cnclX:uint = 0, cnclY:uint = 0 )		{			type = thisPopupType;			isSetEndScore = false;						this.okayY = okY;			this.okayX = okX;			this.cancelX = cnclX;			this.cancelY = cnclY;						if ( stage )			{				onAddtoStage();			}			else			{				addEventListener( Event.ADDED_TO_STAGE, onAddtoStage, false, 0, true );			}		}				public function onAddtoStage( e:Event = null ):void		{			removeEventListener( Event.ADDED_TO_STAGE, onAddtoStage );						if ( type == "about" )			{				addChild( aboutBitmap );			}			else if ( type == "instructions" )			{				addChild( instructionsBitmap );			}			else if ( type == "setendingscore" )			{				addChild( setEndScoreBitmap );				isSetEndScore = true;			}			else if ( type == "scorewarning" )			{				addChild( scoreWarningBitmap );			}						okayButton = new OkayButton;			okayButton.x = okayX;			okayButton.y = okayY;			addChild( okayButton );						if ( isSetEndScore )			{				setEndScore();				okayButton.addEventListener( Event.COMPLETE, attemptDone, false, 0, true );			}			else			{				okayButton.addEventListener( Event.COMPLETE, done, false, 0, true );			}		}				public function attemptDone( e:Event ):void		{			if ( parseInt( scoreInput.text ) > 0 && parseInt( scoreInput.text ) < 100 )			{				MovieClip( this.parent ).scoreToWin = scoreInput.text;				done();			}			else			{				popup = new Popup( "scorewarning", XMLContainer.defaultXML.display.scorewarning.@okayx, XMLContainer.defaultXML.display.scorewarning.@okayy );				popup.x = XMLContainer.defaultXML.display.scorewarning.@x;				popup.y = XMLContainer.defaultXML.display.scorewarning.@y;				addChild( popup );								scoreInput.text = MovieClip(this.parent).scoreToWin.toString();								stage.focus = popup;								popup.addEventListener( Event.COMPLETE, closePopup, false, 0, true );			}		}				public function done( e:Event = null ):void		{			dispatchEvent( new Event( Event.COMPLETE ) );		}				public function setEndScore():void		{			cancelButton = new CancelButton();			cancelButton.x = cancelX;			cancelButton.y = cancelY;			addChild( cancelButton );			cancelButton.addEventListener( Event.COMPLETE, done, false, 0, true );						// GNOP! would let you see the bottom two pixels or so of the previous line when you punched in multiple lines.			// Unfortunately, Flash does not have this functionality. If it can't display the whole of the previous line, it won't display any of it.			// The only workaround I can think of would be to have a white box appear above ScoreInput to partially hide the previous line, which would also require			// that ScoreInput become taller when there are two or more lines. Not impossible to implement, but not really worth the trouble ATM.						// Pressing "return" in the original GNOP! is ignored by the textfield; so, if you have the field highlighted, it ignores the return.			// Right now, pressing "return" when the field is highlighted wipes it out. This needs to be fixed, eventually.						scoreInput = new TextField();			scoreInput.x = XMLContainer.defaultXML.display.scoreinput.@x;			scoreInput.y = XMLContainer.defaultXML.display.scoreinput.@y;			scoreInput.width = XMLContainer.defaultXML.display.scoreinput.@width;			scoreInput.height = XMLContainer.defaultXML.display.scoreinput.@height;			scoreInput.gridFitType = GridFitType.PIXEL;			scoreInput.embedFonts = true;			scoreInput.gridFitType = GridFitType.PIXEL;			scoreInput.antiAliasType = AntiAliasType.ADVANCED;			scoreInput.thickness = 0;			scoreInput.sharpness = 0;			scoreInput.defaultTextFormat = new TextFormat( "chicago", 12, 0x000000, null, null, null, null, null, "left" );			scoreInput.text = MovieClip(this.parent).scoreToWin.toString();						addChild( scoreInput );						scoreInput.type = "input";			scoreInput.multiline = true;			scoreInput.wordWrap = true;			scoreInput.maxChars = XMLContainer.defaultXML.display.scoreinput.@maxchars; // Setting this to three makes this much easier to use, but is not GNOP!-esque.			scoreInput.restrict = XMLContainer.defaultXML.display.scoreinput.@restrict;			scoreInput.setSelection( 0, scoreInput.length );			stage.focus = scoreInput;			scoreInput.addEventListener( Event.CHANGE, onEnterText, false, 0, true );		}				// Monitor for changes to the score input box, and if a carriage return is added, remove it from the text field.		// Carriage returns did not impact the text field in the original GNOP!				public function onEnterText( e:Event ):void		{			var urlEncodedText:String = escape( scoreInput.text );						while ( urlEncodedText.indexOf( "%0D" ) != -1 )			{				var firstHalf:String = urlEncodedText.substr( 0, urlEncodedText.indexOf( "%0D" ) );				var secondHalf:String = urlEncodedText.substr( urlEncodedText.indexOf("%0D") + 3, urlEncodedText.length );				urlEncodedText = firstHalf + secondHalf;				scoreInput.text = unescape( urlEncodedText );			}		}				public function closePopup( e:Event ):void		{			removeChild( popup );			popup = null;						scoreInput.scrollV = 1;			scoreInput.scrollH = 1;			scoreInput.setSelection( 0, scoreInput.length );			stage.focus = scoreInput;		}	}}
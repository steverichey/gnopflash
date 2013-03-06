package
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.utils.ByteArray;
    import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	
	public class XMLContainer extends MovieClip
	{
		public static var defaultXML:XML;
		public static var xmlLoader:URLLoader;
		public static var createdXML:Boolean;
		private static var dispatcher:EventDispatcher = new EventDispatcher();
		
		public function XMLContainer()
		{
			
		}
		
		public function loadXML():void
		{
			// Load XML data.
			
			xmlLoader = new URLLoader();
			
			xmlLoader.addEventListener( IOErrorEvent.IO_ERROR, createXML, false, 0, true );
			
			// If the XML data isn't present, the game makes its own using the default values.
			// The user has the option to save the generated XML file if they want to, by "dragging"
			// the septagon to the GNOP! icon.
			
			xmlLoader.addEventListener( Event.COMPLETE, processXML, false, 0, true );
			xmlLoader.load( new URLRequest( "data/Defaults.xml" ) );
		}
		
		public function processXML( e:Event ):void
		{
			createdXML = false;
			xmlLoader.removeEventListener( Event.COMPLETE, processXML );
			defaultXML = new XML( e.target.data );
			
			endLoad();
		}
		
		public static function saveXML():void
		{
			var xmlByteArray:ByteArray = new ByteArray();
			xmlByteArray.writeUTFBytes( defaultXML );
			
			var xmlFileReference:FileReference = new FileReference();
			xmlFileReference.save( xmlByteArray, "Defaults.xml" );
		}
		
		public function endLoad():void
		{
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		public function createXML( e:IOErrorEvent ):void
		{
			defaultXML = new XML( <xml>
				<display>
					<time x="468" y="1" />
					<splash x="69" y="94" />
					<about x="4" y="26" okayx="361" okayy="191" />
					<instructions x="20" y="27" okayx="180" okayy="269" />
					<setendscore x="75" y="45" okayx="122" okayy="67" cancelx="46" cancely="71" />
					<scorewarning x="-42" y="13" okayx="248" okayy="29" />
					<scoreinput x="154" y="28" width="35" height="30" restrict="1234567890" maxchars="3" />
					<play width="516" height="326" color="0xFFFFFF" xpadding="8" ytoppadding="0" ybottompadding="3" />
				</display>
				
				<io>
					<player type="mouse" />
					<enemy type="ai" speedfactor="1" />
					<velocityratio value="3.6" />
					<ballspeedmultiplier value="10" />
					<tickspeed>
						<speed value="54" />
						<speed value="27" />
						<speed value="18" />
					</tickspeed>
					<serve type="straight" />
					<bounce dampener="0.55" />
					<ai showpath="0" />
					<mouseleave notification="1" />
				</io>
				
				<defaults>
					<player size="2" color="0x000000" multiplier="14" width="8" />
					<enemy size="2" color="0x000000" multiplier="14" width="8" />
					<ball size="2" speed="2" color="0x000000" />
					<difficulty value="2" />
					<scoretowin value="4" />
					<playerservesfirst value="1" />
					<soundtoggle value="1" />
				</defaults>

				<menu>
					<display bgcolor="0xFFFFFF" textcolor="0x000000" />
					<dropmenu header="SEPTAGON">
						<item value="About GNOP..." />
					</dropmenu>
					<dropmenu header="File">
						<item value="New Game" />
						<item value="LINE" />
						<item value="Quit" />
					</dropmenu>
					<dropmenu header="Paddles">
						<item value="GREY_Player" />
						<item value="TAB_Small" />
						<item value="TAB_Normal" />
						<item value="TAB_Large" />
						<item value="LINE" />
						<item value="GREY_Computer" />
						<item value="TAB_Small" />
						<item value="TAB_Normal" />
						<item value="TAB_Large" />
					</dropmenu>
					<dropmenu header="Ball">
						<item value="Small" />
						<item value="Normal" />
						<item value="Large" />
						<item value="LINE" />
						<item value="Slow" />
						<item value="Normal" />
						<item value="Fast" />
					</dropmenu>
					<dropmenu header="Options">
						<item value="Novice" />
						<item value="Intermediate" />
						<item value="Expert" />
						<item value="LINE" />
						<item value="Set Ending Score..." />
						<item value="LINE" />
						<item value="Computer Serves First" />
						<item value="You Serve First" />
						<item value="LINE" />
						<item value="Sound" />
					</dropmenu>
					<dropmenu header="Help">
						<item value="Instructions..." />
					</dropmenu>
				</menu>
			</xml>
			);
			
			createdXML = true;
			endLoad();
		}
	}
}
﻿package  {	import flash.events.Event;		public class NavigationEvent extends Event 	{		public static const LOAD:String = "load";		public static const DESKTOP:String = "desktop";		public static const SPLASH:String = "splash";		public static const PLAY:String = "play";		public static const WIN:String = "win";		public static const LOSE:String = "lose";		public static const QUIT:String = "quit";		public static const QUITGAME:String = "quitgame";		public static const ABOUT:String = "about";		public static const INSTRUCTIONS:String = "instructions";		public static const SETENDINGSCORE:String = "setendingscore";		public static const SAVE:String = "save"; 		public function NavigationEvent( type:String )		{			super( type );		}	}}
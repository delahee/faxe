import faxe.Faxe;


import cpp.Stdlib;
import SndTV;

using cpp.NativeArray;



private class Cpp {
	
	@:generic
	@:extern
	public static inline function addr<T>( a : T ){
		return cpp.Pointer.addressOf(a);
	}
	
	@:generic
	@:extern
	public static inline function rawAddr<T>( a : T ){
		return cpp.RawPointer.addressOf(a);
	}
	
	@:generic
	@:extern
	public static inline function nullptr<T>() : cpp.Pointer<T> {
		return cast null;
	}
	
	@:generic
	@:extern
	public static inline function ref<T>( a : cpp.Pointer<T> ) {
		return cast a.ref;
	}
	
	public static inline function cstring( str : String ) : cpp.ConstCharStar {
		return cpp.ConstCharStar.fromString(str);
	}
	
	public static function bytesToConstCharStar(bytes:haxe.io.Bytes){
		var bd = bytes.getData();
		var cs : cpp.ConstCharStar = cast 0;
		untyped __cpp__("{0} = (const char * )({1})", cs, cpp.NativeArray.getBase(bd).getBase());
		return cs;
	}
}

class Test{
	
	
	static function main()
	{
		Snd.init();
		
		
		if ( false ){
			var file = "07 - Crush (feat. Jay Kloeckner).mp3";
			Faxe.fmod_load_sound( file );
			
			var s = Faxe.fmod_get_sound(file);
			
			var len : cpp.UInt32 = -1;
			s.ptr.getLength( Cpp.addr(len), FmodTimeUnit.FTM_MS );
			
			trace(len);
			Faxe.fmod_play_sound_with_handle( s );
		}
		
		if ( false ){
			var file = "07 - Crush (feat. Jay Kloeckner).mp3";
			Faxe.fmod_load_sound( file );
			Faxe.fmod_play_sound( file );
		}
		
		if ( false ){
			var file = "07 - Crush (feat. Jay Kloeckner).mp3";
			Faxe.fmod_load_sound( file );
			var sound : Snd = Snd.fromFaxe( file );
			//sound.play();
			
			Faxe.fmod_play_sound_with_handle( cast sound.sound.getData() );
		}
		
		if ( false ){
			var file = "07 - Crush (feat. Jay Kloeckner).mp3";
			Faxe.fmod_load_sound( file );
			var sound : Snd = Snd.fromFaxe( file );
			sound.play();
		}
		
		if( false ){
			var sound : Snd = Snd.loadSfx( "07 - Crush (feat. Jay Kloeckner).mp3");
			if ( sound == null){
				trace("err loading sound!");
			}
			
			trace("len:"+sound.getDuration());
			
			sound.play();
			if(sound.isPlaying())
				trace("playing!");
		}
		
		if( false ){
			var sound : Snd = Snd.loadSfx( "07 - Crush (feat. Jay Kloeckner).mp3");
			sound.play();
			trace(sound.volume);
			haxe.Timer.delay( function(){
				sound.fadeStop( 5000 );
			}, 10 * 1000 );
		}
		
		if( false ){
			var sound : Snd = Snd.loadSfx( "07 - Crush (feat. Jay Kloeckner).mp3");
			sound.play();
			trace(sound.volume);
			haxe.Timer.delay( function(){
				trace("panning");
				sound.tweenPan(1, TEase, 2000);
			}, 5 * 1000 );
		}
		
		if ( false ){
			var file = "snd/music/credits.mp3";
			var file = "snd/music/Hell_master.mp3";
			var file = "snd/music/MUSIC_INTRO.mp3";
			var file = "snd/music/WorldMap_master.mp3";
			var sound : Snd = Snd.loadSfx( file );
			sound.play();
		}
		
		if ( false ){
			var file = "win/snd/music/credits.ogg";
			var file = "win/snd/music/Hell_master.ogg";
			var file = "win/snd/music/MUSIC_INTRO.ogg";
			var file = "win/snd/music/WorldMap_master.ogg";
			var file = "win/music/accuser_cymbals.ogg";
			var file = "win/music/BM3_nodrums.ogg";
			var file = "win/snd/samples/deathmetal1_cymbal1.wav";
			var sound : Snd = Snd.loadSfx( file );
			if (sound!=null) sound.play();
			else {
				trace( "no such sound " + file);
			}
		}
		
		if ( false ){
			var file = "win/snd/samples/deathmetal1_cymbal1.wav";
			var sound : Snd = Snd.loadSfx( file );
			if (sound != null) {
				sound.playLoop(5);
			} else {
				trace( "no such sound " + file);
			}
		}
		
		if ( false ){
			var file = "win/snd/samples/deathmetal1_cymbal1.wav";
			var sound : Snd = Snd.loadSfx( file );
			if (sound != null) {
				var d = 800;
				for( i in 0...10)
					haxe.Timer.delay( function(){
						sound.startNoStop();
					}, i * 200 );
			} else {
				trace( "no such sound " + file);
			}
		}
		
		if ( false ){
			var file = "win/snd/samples/deathmetal1_cymbal1.wav";
			var sound : Snd = Snd.loadSfx( file );
			if (sound != null) {
				var d = 800;
				for( i in 0...10)
					haxe.Timer.delay( function(){
						sound.play();
					}, i * 200 );
			} else {
				trace( "no such sound " + file);
			}
		}
		
		if ( false ){
			trace("reading");
			var all :Map<String,Snd> = new Map();
			var dir = "win/snd/SFX";
			for ( path in sys.FileSystem.readDirectory(dir)){
				var snd = Snd.loadSfx( dir + "/" + path );
				if( snd !=null ) 
					all.set(path, snd);
				else{
					trace("not loaded " + snd);
				}
			}
			all.get("BBdino_grunt4.wav").playLoop( 10 ); 
		}
		
		if ( false ){
			trace("reading");
			var t0 = haxe.Timer.stamp();
			var all :Map<String,Snd> = new Map();
			var dir = "win/snd/SFX";
			for ( path in sys.FileSystem.readDirectory(dir)){
				var snd = Snd.loadSfx( dir + "/" + path );
				if( snd !=null ) 
					all.set(path, snd);
				else{
					trace("not loaded " + snd);
				}
			}
			var t1 = haxe.Timer.stamp();
			trace("time to load" + (t1 - t0) + "sec");
			all.get("wind1_loop.wav").fadePlay( 10000 );
		}
		
		
		if ( false ){
			var file = "win/snd/music/Hell_master.ogg";
			var sound : Snd = Snd.loadSfx( file );
			if (sound != null) {
				sound.play();
				
				sound.onStop.addOnce(function(){
					trace("disposing");
					sound.dispose();
				});
				
				haxe.Timer.delay( function(){
					trace("fading...");
					sound.fadeStop( 10000 );
				},1000);
			}
			else {
				trace( "no such sound " + file);
			}
		}
		
		if ( false ){
			var file = "win/snd/music/Hell_master.ogg";
			var sound : Snd = Snd.loadSfx( file );
			if (sound != null) {
				sound.play();
				haxe.Timer.delay( function(){
					trace("lower");
					Snd.setGlobalVolume( 0.5 );
				}, 5000);
				
				haxe.Timer.delay( function(){
					trace("top");
					Snd.setGlobalVolume( 1.0 );
				}, 10000);
				
				haxe.Timer.delay( function(){
					trace("zero");
					Snd.setGlobalVolume( 0.0 );
				}, 15000);
			}
			else {
				trace( "no such sound " + file);
			}
		}
		
		if ( false ){
			var file = "win/snd/music/Hell_master.ogg";
			var sound : Snd = Snd.loadSong( file );
			if (sound != null) {
				sound.play();
				haxe.Timer.delay( function(){
					sound.setPlayCursorSec( 60 );
				}, 5000);
			}
			else {
				trace( "no such sound " + file);
			}
			
		}
		
		if ( false ){
			var file = "win/snd/music/Hell_master.ogg";
			var fmod = FaxeRef.getSystem();
			trace("fm init mem:\t" + Snd.dumpMemory());
			var sound : Snd = Snd.loadSfx( file );
			trace("load mem:\t\t" + Snd.dumpMemory());
			
			if (sound != null) {
				sound.play();
				
				haxe.Timer.delay( function(){
					trace("playin mem:\t" + Snd.dumpMemory());
					sound.dispose();
					trace("dispose mem:\t" + Snd.dumpMemory());
					cpp.vm.Gc.run(true);
					trace("gc runmem:" + Snd.dumpMemory());
				},5000);
				
				haxe.Timer.delay( function(){
					trace("long aftermem: \t" + Snd.dumpMemory());
					Sys.command("pause");
					Sys.exit(0);
				},10000);
			}
			else {
				trace( "no such sound " + file);
			}
		}
		
		if ( false ){
			var file = "win/snd/music/Hell_master.ogg";
			var fmod = FaxeRef.getSystem();
			trace("fm init mem:\t" + Snd.dumpMemory());
			var sound : Snd = Snd.loadSong( file );
			trace("load mem:\t\t" + Snd.dumpMemory());
			
			if (sound != null) {
				sound.play();
				
				haxe.Timer.delay( function(){
					trace("playin mem:\t" + Snd.dumpMemory());
					sound.dispose();
					trace("dispose mem:\t" + Snd.dumpMemory());
					cpp.vm.Gc.run(true);
					trace("gc runmem:\t" + Snd.dumpMemory());
				},5000);
				
				haxe.Timer.delay( function(){
					trace("long aftermem:\t" + Snd.dumpMemory());
					Sys.command("pause");
					Sys.exit(0);
				},10000);
			}
			else {
				trace( "no such sound " + file);
			}
		}
		
		if ( false ){
			var bnk = Snd.loadSingleBank("Master Bank.bank");
			if ( null==bnk ) trace("no such bank 0");
			var bnk = Snd.loadSingleBank("Master Bank.strings.bank");
			if ( null==bnk ) trace("no such bank 1");
			var bnk = Snd.loadSingleBank("Musics.bank");
			if ( null==bnk ) trace("no such bank 2");
		}
		
		if ( true ){
			var bnk = Snd.loadSingleBankMem("Master Bank.bank");
			if ( null == bnk ) trace("no such bank 0");
			
			var t0 = haxe.Timer.stamp();
			var load = bnk.loadSampleData();
			var t1 = haxe.Timer.stamp();
			trace("time to loadSamples " + (t1 - t0) + "s");
			var bnkMaster = bnk;
			
			var bnk = Snd.loadSingleBankMem("Master Bank.strings.bank");
			if ( null == bnk ) trace("no such bank 1");
			var t0 = haxe.Timer.stamp();
			var load = bnk.loadSampleData();
			var t1 = haxe.Timer.stamp();
			trace("time to loadSamples " + (t1 - t0) + "s");
			var bnkStrings = bnk;
			
			
			var bnk = Snd.loadSingleBankMem("Musics.bank");
			if ( null == bnk ) trace("no such bank 2");
			
			var t0 = haxe.Timer.stamp();
			var load = bnk.loadSampleData();
			var t1 = haxe.Timer.stamp();
			trace("time to loadSamples " + (t1 - t0) + "s");
			
			
			var cnt = 0;
			var evRes:FmodResult = bnk.getEventCount( Cpp.addr(cnt ));
			
			var l : Array<String> = FaxeRef.getEventList( bnk, cnt );
			trace(cnt + "<>" + l.length);
			var i = 0;
			for ( name in l ){
				trace(i+" :"+name);
			}
			
			var ss = FaxeRef.getStudioSystem();
			var ev = ss.getEvent( "event:/accuser_nodrums" );
			if ( ev == null){
				trace("no such event");
			}
			else {
				trace("got one");
				var inst = ev.createInstance();
				inst.start();
			}
		}
		
		var h = new haxe.Timer( 15);
		h.run = function(){
			Snd.update();
			//trace("update");
		}
	}
	
	
	
	
}

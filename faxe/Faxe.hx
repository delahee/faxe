package faxe;

import cpp.NativeGc;

private typedef Ptr<T> = cpp.Pointer<T>;
private typedef RawPtr<T> = cpp.RawPointer<T>;
typedef FmodEventList = cpp.RawPointer<cpp.RawPointer<FmodStudioEventDescription>>;

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
		var cs : cpp.ConstCharStar = null;
		untyped __cpp__("{0} = (const char * )({1})", cs, cpp.NativeArray.getBase(bd).getBase());
		return cs;
	}
}

@:keep
@:include('linc_faxe.h')
#if !display
@:build(linc.Linc.touch())
@:build(linc.Linc.xml('faxe'))
#end
extern class Faxe
{
	@:native("linc::faxe::faxe_init")
	public static function fmod_init(numChannels:Int = 128):Void;
	
	@:native("linc::faxe::faxe_close")
	public static function fmod_close():Void;
	
	@:native("linc::faxe::faxe_release")
	public static function fmod_release():Void;

	@:native("linc::faxe::faxe_update")
	public static function fmod_update():Void;

	@:native("linc::faxe::faxe_load_bank")
	public static function fmod_load_bank(bankFilePath:String):Void;

	@:native("linc::faxe::faxe_unload_bank")
	public static function fmod_unload_bank(bankFilePath:String):Void;

	/**
	 * registered the sounds internally
	 */
	@:native("linc::faxe::faxe_load_sound")
	public static function fmod_load_sound(soundPath:String, looping:Bool = false, streaming:Bool = false):FmodResult;

	/**
	 * get registerd sounds
	 */
	@:native("linc::faxe::faxe_get_sound")
	public static function fmod_get_sound(soundPath:String):cpp.Pointer<FmodSound>;
	
	@:native("linc::faxe::faxe_unload_sound")
	public static function fmod_unload_sound(bankFilePath:String):Void;

	@:native("linc::faxe::faxe_load_event")
	public static function fmod_load_event(eventPath:String, eventName:String):Void;

	@:native("linc::faxe::faxe_play_event")
	public static function fmod_play_event(eventName:String):Void;
	
	@:native("linc::faxe::faxe_play_sound")
	public static function fmod_play_sound(soundName:String, paused:Bool = false):FmodResult;
	
	@:native("linc::faxe::faxe_play_sound_with_handle")
	public static function fmod_play_sound_with_handle(snd : cpp.Pointer<FmodSound>):FmodResult;
	
	@:native("linc::faxe::faxe_play_sound_with_channel")
	public static function fmod_play_sound_with_channel(soundName:String, paused:Bool): cpp.Pointer<FmodChannel>;

	@:native("linc::faxe::faxe_stop_event")
	public static function fmod_stop_event(eventName:String, forceStop:Bool):Void;

	@:native("linc::faxe::faxe_event_playing")
	public static function fmod_event_is_playing(eventName:String):Bool;

	@:native("linc::faxe::faxe_get_event_param")
	public static function fmod_get_param(eventName:String, paramName:String):Float;

	@:native("linc::faxe::faxe_set_event_param")
	public static function fmod_set_param(eventName:String, paramName:String, sValue:Float):Void;
	
	@:native("linc::faxe::faxe_get_system")
	public static function fmod_get_system() : cpp.Pointer<FmodSystem>;
	
	@:native("linc::faxe::faxe_get_studio_system")
	public static function fmod_get_studio_system() : cpp.Pointer<FmodStudioSystem>;
	
	@:native("linc::faxe::faxe_set_debug")
	public static function fmod_set_debug(onOff : Bool):Void;
}

@:enum abstract FmodTimeUnit(Int) from Int to Int {
	var FTM_MS 			= 0x00000001;
	var FTM_PCM 		= 0x00000002;
	var FTM_PCMBYTES 	= 0x00000004;
	var FTM_RAWBYTES 	= 0x00000008;
	var FTM_PCMFRACTION = 0x00000010;
	var FTM_MODORDER 	= 0x00000100;
	var FTM_MODROW		= 0x00000200;
	var FTM_MODPATTERN 	= 0x00000400;
}

@:enum abstract FmodBankInitFlags(Int) from Int to Int {
	var FSBANK_INIT_NORMAL                            = 0x0;
	var FSBANK_INIT_IGNOREERRORS                      = 0x1;
	var FSBANK_INIT_WARNINGSASERRORS                  = 0x2;
	var FSBANK_INIT_CREATEINCLUDEHEADER               = 0x4;
	var FSBANK_INIT_DONTLOADCACHEFILES                = 0x8;
	var FSBANK_INIT_GENERATEPROGRESSITEMS             = 0x10;
}

@:enum abstract FmodBankBuilFlags(Int) from Int to Int {
	var FSBANK_BUILD_DEFAULT                   = 0x0;
	var FSBANK_BUILD_DISABLESYNCPOINTS         = 0x1;
	var FSBANK_BUILD_DONTLOOP                  = 0x2;
	var FSBANK_BUILD_FILTERHIGHFREQ            = 0x4;
	var FSBANK_BUILD_DISABLESEEKING            = 0x8;
	var FSBANK_BUILD_OPTIMIZESAMPLERATE        = 0x10;
	var FSBANK_BUILD_FSB5_DONTWRITENAMES       = 0x80;
	var FSBANK_BUILD_NOGUID             	   = 0x100;
	var FSBANK_BUILD_WRITEPEAKVOLUME           = 0x200;
	//var FSBANK_BUILD_OVERRIDE_MASK             = 0x10;
	//var FSBANK_BUILD_CACHE_VALIDATION_MASK     = 0x10;
}

/*
@:enum abstract FmodStudioLoadingState(Int) from Int to Int {
	var FMOD_STUDIO_LOADING_STATE_UNLOADING = 0;
	var FMOD_STUDIO_LOADING_STATE_UNLOADED = 1;
	var FMOD_STUDIO_LOADING_STATE_LOADING = 2;
	var FMOD_STUDIO_LOADING_STATE_LOADED = 3; 
	var FMOD_STUDIO_LOADING_STATE_ERROR = 4;   
}
*/

@:enum abstract FmodStudioLoadBank(Int) from Int to Int {
	var FMOD_STUDIO_LOAD_BANK_NORMAL                =0x00000000;         	
	var FMOD_STUDIO_LOAD_BANK_NONBLOCKING           =0x00000001;
	var FMOD_STUDIO_LOAD_BANK_DECOMPRESS_SAMPLES    =0x00000001;
}


/*
@:enum abstract FmodStudioLoadMemoryMode(Int) from Int to Int {
	var FMOD_STUDIO_LOAD_MEMORY                = 0x00000000;         	
	var FMOD_STUDIO_LOAD_MEMORY_POINT          = 0x00000001;
}
*/

@:keep
@:include('linc_faxe.h')
@:native("FMOD_STUDIO_LOADING_STATE")
extern class FmodStudioLoadingState {
	
	@:extern
	static inline function error() : FmodStudioLoadingState{
		return untyped __cpp__('FMOD_STUDIO_LOADING_STATE_ERROR');
	}
	
	@:extern
	inline function isLoaded() : Bool {
		return untyped __cpp__('{0} == FMOD_STUDIO_LOADING_STATE_LOADED',this);
	}
}

@:keep
@:include('linc_faxe.h')
@:native("FMOD_STUDIO_LOAD_MEMORY_MODE")
extern class FmodStudioLoadMemoryMode {
	
	@:extern
	static inline function getMemoryCopy():FmodStudioLoadMemoryMode{
		return untyped __cpp__("FMOD_STUDIO_LOAD_MEMORY");
	}
	
	@:extern
	static inline function getMemoryPoint():FmodStudioLoadMemoryMode{
		return untyped __cpp__("FMOD_STUDIO_LOAD_MEMORY_POINT");
	}
}

@:keep
@:include('linc_faxe.h')
@:native("FMOD_STUDIO_STOP_MODE")
extern class FmodStudioStopMode {
	
	@:extern
	static inline function StopAllowFadeout():FmodStudioStopMode
		return untyped __cpp__("FMOD_STUDIO_STOP_ALLOWFADEOUT");
	
	@:extern
	static inline function StopImmediate():FmodStudioStopMode
		return untyped __cpp__("FMOD_STUDIO_STOP_IMMEDIATE");
}

@:enum abstract FmodResult(Int) from Int to Int {
	var FMOD_OK													= 0;
	var FMOD_ERR_BADCOMMAND										= 1;
	var FMOD_ERR_CHANNEL_ALLOC									= 2;
	var FMOD_ERR_CHANNEL_STOLEN									= 3;
	var FMOD_ERR_DMA											= 4;
	var FMOD_ERR_DSP_CONNECTION									= 5;
	var FMOD_ERR_DSP_DONTPROCESS								= 6;
	var FMOD_ERR_DSP_FORMAT										= 7;
	var FMOD_ERR_DSP_INUSE										= 8;
	var FMOD_ERR_DSP_NOTFOUND									= 9;
	var FMOD_ERR_DSP_RESERVED									= 10;
	var FMOD_ERR_DSP_SILENCE									= 11;
	var FMOD_ERR_DSP_TYPE										= 12;
	var FMOD_ERR_FILE_BAD										= 13;
	var FMOD_ERR_FILE_COULDNOTSEEK								= 14;
	var FMOD_ERR_FILE_DISKEJECTED								= 15;
	var FMOD_ERR_FILE_EOF										= 16;
	var FMOD_ERR_FILE_ENDOFDATA									= 17;
	var FMOD_ERR_FILE_NOTFOUND									= 18;
	var FMOD_ERR_FORMAT											= 19;
	var FMOD_ERR_HEADER_MISMATCH								= 20;
	var FMOD_ERR_HTTP											= 21;
	var FMOD_ERR_HTTP_ACCESS									= 22;
	var FMOD_ERR_HTTP_PROXY_AUTH								= 23;
	var FMOD_ERR_HTTP_SERVER_ERROR								= 24;
	var FMOD_ERR_HTTP_TIMEOUT									= 25;
	var FMOD_ERR_INITIALIZATION									= 26;
	var FMOD_ERR_INITIALIZED									= 27;
	var FMOD_ERR_INTERNAL										= 28;
	var FMOD_ERR_INVALID_FLOAT									= 29;
	var FMOD_ERR_INVALID_HANDLE									= 30;
	var FMOD_ERR_INVALID_PARAM									= 31;
	var FMOD_ERR_INVALID_POSITION								= 32;
	var FMOD_ERR_INVALID_SPEAKER								= 33;
	var FMOD_ERR_INVALID_SYNCPOINT								= 34;
	var FMOD_ERR_INVALID_THREAD									= 35;
	var FMOD_ERR_INVALID_VECTOR									= 36;
	var FMOD_ERR_MAXAUDIBLE										= 37;
	var FMOD_ERR_MEMORY											= 38;
	var FMOD_ERR_MEMORY_CANTPOINT								= 39;
	var FMOD_ERR_NEEDS3D										= 40;
	var FMOD_ERR_NEEDSHARDWARE									= 41;
	var FMOD_ERR_NET_CONNECT									= 42;
	var FMOD_ERR_NET_SOCKET_ERROR								= 43;
	var FMOD_ERR_NET_URL										= 44;
	var FMOD_ERR_NET_WOULD_BLOCK								= 45;
	var FMOD_ERR_NOTREADY										= 46;
	var FMOD_ERR_OUTPUT_ALLOCATED								= 47;
	var FMOD_ERR_OUTPUT_CREATEBUFFER							= 48;
	var FMOD_ERR_OUTPUT_DRIVERCALL								= 49;
	var FMOD_ERR_OUTPUT_FORMAT									= 50;
	var FMOD_ERR_OUTPUT_INIT									= 51;
	var FMOD_ERR_OUTPUT_NODRIVERS								= 52;
	var FMOD_ERR_PLUGIN											= 53;
	var FMOD_ERR_PLUGIN_MISSING									= 54;
	var FMOD_ERR_PLUGIN_RESOURCE								= 55;
	var FMOD_ERR_PLUGIN_VERSION									= 56;
	var FMOD_ERR_RECORD											= 57;
	var FMOD_ERR_REVERB_CHANNELGROUP							= 58;
	var FMOD_ERR_REVERB_INSTANCE								= 59;
	var FMOD_ERR_SUBSOUNDS										= 60;
	var FMOD_ERR_SUBSOUND_ALLOCATED								= 61;
	var FMOD_ERR_SUBSOUND_CANTMOVE								= 62;
	var FMOD_ERR_TAGNOTFOUND									= 63;
	var FMOD_ERR_TOOMANYCHANNELS								= 64;
	var FMOD_ERR_TRUNCATED										= 65;
	var FMOD_ERR_UNIMPLEMENTED									= 66;
	var FMOD_ERR_UNINITIALIZED									= 67;
	var FMOD_ERR_UNSUPPORTED									= 68;
	var FMOD_ERR_VERSION										= 69;
	var FMOD_ERR_EVENT_ALREADY_LOADED							= 70;
	var FMOD_ERR_EVENT_LIVEUPDATE_BUSY							= 71;
	var FMOD_ERR_EVENT_LIVEUPDATE_MISMATCH						= 72;
	var FMOD_ERR_EVENT_LIVEUPDATE_TIMEOUT						= 73;
	var FMOD_ERR_EVENT_NOTFOUND									= 74;
	var FMOD_ERR_STUDIO_UNINITIALIZED							= 75;
	var FMOD_ERR_STUDIO_NOT_LOADED								= 76;
	var FMOD_ERR_INVALID_STRING									= 77;
	var FMOD_ERR_ALREADY_LOCKED									= 78;
	var FMOD_ERR_NOT_LOCKED										= 79;
	var FMOD_ERR_RECORD_DISCONNECTED							= 80;
	var FMOD_ERR_TOOMANYSAMPLES									= 81;
}

@:enum abstract FmodMode(Int) from Int to Int {
	var FMOD_DEFAULT 		 				= 0x00000000;
	var FMOD_LOOP_OFF 		 				= 0x00000001;
	var FMOD_LOOP_NORMAL 	 				= 0x00000002;
	var FMOD_LOOP_BIDI 		 				= 0x00000004;
	var FMOD_2D  			 				= 0x00000008;
	var FMOD_3D  			 				= 0x00000010;
	var FMOD_CREATESTREAM  					= 0x00000080;
	var FMOD_CREATESAMPLE 					= 0x00000100;
	var FMOD_CREATECOMPRESSEDSAMPLE 		= 0x00000200;
	var FMOD_OPENUSER  			 			= 0x00000400;
	var FMOD_OPENMEMORY  			 		= 0x00000800;
	var FMOD_OPENMEMORY_POINT  			 	= 0x10000000;
	var FMOD_OPENRAW  			 			= 0x00001000;
	var FMOD_OPENONLY  			 			= 0x00002000;
	var FMOD_ACCURATETIME  			 		= 0x00004000;
	var FMOD_MPEGSEARCH  			 		= 0x00008000;
	var FMOD_NONBLOCKING  			 		= 0x00010000;
	var FMOD_UNIQUE  			 			= 0x00020000;
	var FMOD_3D_HEADRELATIVE  			 	= 0x00040000;
	var FMOD_3D_WORLDRELATIVE  			 	= 0x00080000;
	var FMOD_3D_INVERSEROLLOFF  			= 0x00100000;
	var FMOD_3D_LINEARROLLOFF  			 	= 0x00200000;
	var FMOD_3D_LINEARSQUAREROLLOFF 		= 0x00400000;
	var FMOD_3D_INVERSETAPEREDROLLOFF  		= 0x00800000;
	var FMOD_3D_CUSTOMROLLOFF  			 	= 0x04000000;
	var FMOD_3D_IGNOREGEOMETRY  			= 0x40000000;
	var FMOD_IGNORETAGS  			 		= 0x02000000;
	var FMOD_LOWMEM  			 			= 0x08000000;
	var FMOD_LOADSECONDARYRAM  			 	= 0x20000000;
	var FMOD_VIRTUAL_PLAYFROMSTART 			= 0x80000000;
}

@:keep
@:include('linc_faxe.h')
@:native("FMOD::Sound")
extern class FmodSound {
	@:native('getMode')
	function getMode( mode : cpp.Pointer<FmodMode> ) : FmodResult;
	
	@:native('getLoopCount')
	function getLoopCount( nb:cpp.Pointer<Int> ) : FmodResult;
	
	@:native('setLoopCount')
	function setLoopCount( nb:Int ) : FmodResult;
	
	@:native('setMode')
	function setMode( mode:FmodMode ) : FmodResult;
	
	@:native('getPosition')
	function getPosition( position : cpp.Pointer<cpp.UInt32>, postype : FmodTimeUnit ) : FmodResult;
	
	@:native('setPosition')
	function setPosition( position : cpp.UInt32, postype : FmodTimeUnit ) : FmodResult;
	
	@:native('getLength')
	function getLength( len : cpp.Pointer<cpp.UInt32>, postype : FmodTimeUnit ) : FmodResult;
	
	//use faxe release to fully release memory... 
	@:native('release')
	function release() : FmodResult;
}


@:keep
@:include('linc_faxe.h')
@:native("FMOD::ChannelGroup")
extern class FmodChannelGroup {
	
}

@:keep
@:include('linc_faxe.h')
@:native("::cpp::Reference<FMOD::Sound>") 
extern class FmodSoundRef extends FmodSound {}

@:include('linc_faxe.h')
@:native("FMOD::Studio::Bank")
extern class FmodStudioBank {
	
	@:native('unload')
	function unload() : FmodResult;
	
	@:native('getLoadingState')
	function getLoadingState( state : cpp.Pointer<FmodStudioLoadingState>) : FmodResult;
	
	
	@:native('getSampleLoadingState')
	function getSampleLoadingState(state : cpp.Pointer<Int>): FmodResult;
	
	@:native('getStringCount')
	function getStringCount(cont : cpp.Pointer<Int>): FmodResult;
	
	@:native('isValid')
	function isValid(): Bool;
	
	@:native('loadSampleData')
	function loadSampleData(): FmodResult;
	
	@:native('unloadSampleData')
	function unloadSampleData(): FmodResult;
	
	@:native('getEventCount')
	function getEventCount(cont : cpp.Pointer<Int>): FmodResult;
	
	@:native('getEventList')
	function getEventList(
		array : cpp.RawPointer<cpp.RawPointer<FmodStudioEventDescription>>,
		capacity:Int,
		cont : cpp.Pointer<Int>
	): FmodResult;
	
}

@:keep
@:include('linc_faxe.h')
@:native("::cpp::Reference<FMOD::Studio::Bank>") 
extern class FmodStudioBankRef extends FmodStudioBank {
	
}

@:include('linc_faxe.h')
@:native("FMOD::Channel")
extern class FmodChannel {
	
	@:native('getVolume')
	function getVolume( volume : cpp.Pointer<cpp.Float32> ) : FmodResult;
	
	@:native('setVolume')
	function setVolume( volume : cpp.Float32 ) : FmodResult;
	
	@:native('getPosition')
	function getPosition( position : cpp.Pointer<cpp.UInt32>, postype : FmodTimeUnit ) : FmodResult;
	
	@:native('setPosition')
	function setPosition( position : cpp.UInt32, postype : FmodTimeUnit ) : FmodResult;
	
	/**
	 * Stops the channel (or all channels in the channel group) from playing. Makes it available for re-use by the priority system.
	 */
	@:native('stop')
	function stop() : FmodResult;
	
	@:native('release')
	function release() : FmodResult;
	
	@:native('isPlaying')
	function isPlaying( isPlaying : cpp.Pointer<Bool> ) : FmodResult;
	
	@:native('getMode')
	function getMode( mode : cpp.Pointer<FmodMode> ) : FmodResult;
	
	@:native('getLoopCount')
	function getLoopCount( nb:cpp.Pointer<Int> ) : FmodResult;
	
	@:native('setLoopCount')
	function setLoopCount( nb:Int ) : FmodResult;
	
	@:native('setMode')
	function setMode( mode:FmodMode ) : FmodResult;
	
	@:native('getPaused')
	function getPaused( paused : cpp.Pointer<Bool> ) : FmodResult;
	
	@:native('setPaused')
	function setPaused( paused : Bool ) : FmodResult;
	
	@:native('setPan')
	function setPan( pan : Float ) : FmodResult;
}

@:keep
@:include('linc_faxe.h')
@:native("::cpp::Reference<FMOD::Channel>") 
extern class FmodChannelRef extends FmodChannel {}

@:keep
@:include('linc_faxe.h')
@:native("FMOD::System")
extern class FmodSystem {
	
	@:native('close')
	function close() : FmodResult;
	
	@:native('createSound')
	function createSound( 
		name_or_data : cpp.ConstCharStar, 
		mode : FmodMode, 
		createExInfo : cpp.Pointer<FmodCreateSoundExInfo>, 
		sound:cpp.RawPointer<cpp.RawPointer<FmodSound>>) : FmodResult;
		
		
	@:native('getSoundRAM')
	function getSoundRAM(
		currentAlloced:cpp.Pointer<Int>,
		maxAlloced:cpp.Pointer<Int>,
		total:cpp.Pointer<Int>
	) : FmodResult;
	
	@:native('playSound')
	function playSound(
		sound 			: cpp.Pointer<FmodSound>,
		channelgroup 	: cpp.Pointer<FmodChannelGroup>,
		paused 			: Bool,
		channel			: cpp.RawPointer<cpp.RawPointer<FmodChannel>>
	) : FmodResult;
	
	
	
	@:native('getCPUUsage')
	function getCPUUsage( usage : cpp.RawPointer<FmodStudioCpuUsage> ):FmodResult;
	
	
}

@:keep
@:include('linc_faxe.h')
@:native("::cpp::Reference<FMOD::System>") 
extern class FmodSystemRef extends FmodSystem {}

@:keep
@:include('linc_faxe.h')
@:native("FMOD_STUDIO_ADVANCEDSETTINGS")
extern class FmodStudioAdvanceSettings{
	var cbsize : Int;
	var commandqueuesize : cpp.UInt32;
	var handleinitialsize : cpp.UInt32;
	var studioupdateperiod : Int;
	var idlesampledatapoolsize : Int;
	var streamingscheduledelay : cpp.UInt32;
}

@:keep
@:include('linc_faxe.h')
@:native("FMOD_STUDIO_CPU_USAGE")
extern class FmodStudioCpuUsage{
	var dspusage:cpp.Float32;
	var streamusage:cpp.Float32;
	var geometryusage:cpp.Float32;
	var updateusage:cpp.Float32;
	var studiousage:cpp.Float32;
}

@:keep
@:include('linc_faxe.h')
@:native("::cpp::Struct<FMOD_STUDIO_CPU_USAGE>")
extern class FmodStudioCpuUsageStruct extends FmodStudioCpuUsage{
	
}

@:keep
@:include('linc_faxe.h')
@:native("FMOD::Studio::EventDescription")
extern class FmodStudioEventDescription{
	
	@:native("getLength")
	function getLength(lenMs:Ptr<Int>):FmodResult;
	
	@:native("isOneshot")
	function isOneshot(onesho:Ptr<Bool>):FmodResult;
	
	@:native("getSampleLoadingState")
	function getSampleLoadingState(loadingState:Ptr<FmodStudioLoadingState>):FmodResult;
	
	//don't use at will as it will increment the ref counter
	@:native("loadSampleData")
	function loadSampleData():FmodResult;
	
	@:native("unloadSampleData")
	function unloadSampleData():FmodResult;
	
	@:native("getPath")
	function _getPath( path:RawPtr<cpp.Char>, size:Int, retrieved:Ptr<Int> ) : FmodResult;

	@:native("createInstance")
	function _createInstance(
		instance : cpp.RawPointer<cpp.RawPointer<FmodStudioEventInstance>>
	) : FmodResult;
	
	inline function createInstance() : FmodStudioEventInstanceRef {
		var inst : cpp.RawPointer<FmodStudioEventInstance> = null;
		var res = _createInstance(Cpp.rawAddr(inst));
		if ( res != FMOD_OK ){
			return null;
		}else {
			return cast cpp.Pointer.fromRaw(inst).ref;
		}
	};
	
	inline function isLoaded():Bool{
		var loadingState:FmodStudioLoadingState = FmodStudioLoadingState.error();
		getSampleLoadingState( Cpp.addr(loadingState));
		return loadingState.isLoaded();
	}
	
	@:native("releaseAllInstances")
	function releaseAllInstances():FmodStudioEventInstanceRef;
}

@:keep
@:include('linc_faxe.h')
@:native("::cpp::Pointer<FMOD::Studio::EventDescription>") 
extern class FmodStudioEventDescriptionPtr extends FmodStudioEventDescription {}

@:keep
@:include('linc_faxe.h')
@:native("::cpp::Reference<FMOD::Studio::EventDescription>") 
extern class FmodStudioEventDescriptionRef extends FmodStudioEventDescription {}


@:keep
@:include('linc_faxe.h')
@:native("FMOD::Studio::EventInstance")
extern class FmodStudioEventInstance{

	@:native("start")
	function start() : FmodResult;
	
	@:native("stop")
	function stop( mode:FmodStudioStopMode ) : FmodResult;
	
	@:native("release")
	function release() : FmodResult;
	
	@:native("getVolume")
	function getVolume(volume:Ptr<cpp.Float32>, finalvolume:Ptr<cpp.Float32>) : FmodResult;
	
	@:native("setVolume")
	function setVolume(volume:Float) : FmodResult;
	
	@:native("getPaused")
	function getPaused(paused:Ptr<Bool>) : FmodResult;
	
	@:native("setPaused")
	function setPaused(paused:Bool) : FmodResult;
	
	@:native("getTimelinePosition")
	function getTimelinePosition(position:Ptr<Int>) : FmodResult;
	
	@:native("setTimelinePosition")
	function setTimelinePosition(position:Int) : FmodResult;
	
	
}

@:keep
@:include('linc_faxe.h')
@:native("::cpp::Reference<FMOD::Studio::EventInstance>") 
extern class FmodStudioEventInstanceRef extends FmodStudioEventInstance {}

@:keep
@:include('linc_faxe.h')
@:native("FMOD::Studio::System")
extern class FmodStudioSystem {
	@:native('loadBankFile')
	function loadBankFile( filename : cpp.ConstCharStar, loadFlags:Int, bank : cpp.RawPointer<cpp.RawPointer<FmodStudioBank>>  ) : FmodResult;
	
	@:native('loadBankMemory')
	function loadBankMemory( 
		data : cpp.ConstCharStar, 
		size:Int, 
		mode : FmodStudioLoadMemoryMode, 
		loadFlags:Int, 
		bank : cpp.RawPointer<cpp.RawPointer<FmodStudioBank>>  ) : FmodResult;
	
	@:native('getEvent')
	function _getEvent( path : cpp.ConstCharStar, desc : cpp.RawPointer<cpp.RawPointer<FmodStudioEventDescription>>
		) : FmodResult;
		
		
	public inline function getEvent( path : String ) : FmodStudioEventDescriptionRef{
		var desc : cpp.RawPointer<FmodStudioEventDescription> = null;
		var res = _getEvent( cpp.ConstCharStar.fromString(path), Cpp.rawAddr(desc ));
		if ( res != FMOD_OK ){
			#if debug
			trace("getEvent failed : "+path+" err:"+FaxeRef.fmodResultToString(res) );
			#end
			return null;
		}
		if ( desc == null)
			return null;
		return cast cpp.Pointer.fromRaw(desc).ref;
	}
	
	@:native('flushCommands')
	function flushCommands():FmodResult;
	
	@:native('flushSampleLoading')
	function flushSampleLoading():FmodResult;
}



@:keep
@:include('linc_faxe.h')
@:native("::cpp::Reference<FMOD::Studio::System>") 
extern class FmodStudioSystemRef extends FmodStudioSystem {}

@:keep
@:include('linc_faxe.h')
@:cppFileCode("#include \"linc_faxe.h\"\n#include <hx/GC.h>\n")
class FaxeRef {
	@:extern
	public static inline function getSystem() : FmodSystemRef{
		var ptr : cpp.Pointer<FmodSystem> = Faxe.fmod_get_system();
		return cast ptr.ref;
	}
	
	@:extern
	public static inline function getStudioSystem() : FmodStudioSystemRef{
		var ptr : cpp.Pointer<FmodStudioSystem> = Faxe.fmod_get_studio_system();
		return cast ptr.ref;
	}
	
	@:extern
	public static inline function playSound(name:String, ?paused = false) : FmodChannelRef {
		var ptr : cpp.Pointer<FmodChannel> = Faxe.fmod_play_sound_with_channel(name,paused);
		return cast ptr.ref;
	}
	
	public static function Memory_GetStats(currentAlloced:Ptr<Int>, maxAlloced:Ptr<Int>, isBlockingOrFast:Bool) : FmodResult {
		return untyped __cpp__("FMOD::Memory_GetStats({0},{1},{2})",currentAlloced,maxAlloced,isBlockingOrFast);
	}
	
	@:generic
	@:extern
	public static inline function nullptr<T>() : cpp.Pointer<T> {
		return cast null;
	}
	
	@:generic
	@:extern
	public static inline function nullptrR<T>() : cpp.RawPointer<T> {
		return cast null;
	}
	
	public static function playSoundWithHandle(snd:FmodSoundRef, ?paused : Bool = false) : FmodChannelRef {
		var fmod : FmodSystemRef = getSystem();
		
		var cgroup : cpp.Pointer<FmodChannelGroup> = nullptr();
		var chan : cpp.RawPointer<FmodChannel> = nullptrR();
		var chanPtr : cpp.RawPointer<cpp.RawPointer<FmodChannel>> = cpp.RawPointer.addressOf(chan);
		
		//Reference are actually pointers !
		var sndPtr : cpp.Pointer<FmodSound> = cast snd;
		var res = fmod.playSound( sndPtr, cgroup, paused, chanPtr );
		
		if ( res != FMOD_OK ){
			#if debug
			trace("[Faxe] Play sound error "+ FaxeRef.fmodResultToString(res));
			#end
			return null;
		}
		
		return cast cpp.Pointer.fromRaw(chan).ref;
	}
	
	@:extern
	public static inline function getSound(name:String) : FmodSoundRef {
		var ptr : cpp.Pointer<FmodSound> = Faxe.fmod_get_sound(name);
		return cast ptr.ref;
	}
	
	public static function getEventList( bnk : FmodStudioBankRef ) : Array<String>{
		var arrRes : Array<String> = [];
		var cnt : Int = 0;
		var res = bnk.getEventCount( cpp.Pointer.addressOf(cnt) );
		if ( res != FMOD_OK) {
			trace( fmodResultToString(res ));
			return arrRes;
		}
		if ( null==bnk){
			trace("no bank given");
			return arrRes ;
		}
		
		trace("scanned for " + cnt + " events");
		var fmodRes = 0;
		
		untyped __cpp__('
			FMOD::Studio::Bank * bank = {1};
			int nb = {0};
			
			printf("trying to fetch : %d\\n", nb);
			size_t allocSize = cnt * sizeof(FMOD::Studio::EventDescription * );
			FMOD::Studio::EventDescription ** arr =  (FMOD::Studio::EventDescription **) malloc( allocSize );
			int nbDone = 0;
			{3} = bnk->getEventList(arr, nb, &nbDone);
			if ( {3} != FMOD_OK ){
				printf("fmod res: %d\\n", fmodRes);
			}
			else {
				printf("nbDone: %d\\n", nbDone);
				char label[512];
				for ( int i = 0; i < nbDone;++i ){
					int strl = 0;
					{3} = arr[i]->getPath(label, 511, &strl);
					{2}->push( ::String(label,strl+1).dup() );
				}
				free(arr);
			}
		',cnt, bnk,arrRes,fmodRes);
		
		if ( fmodRes != FMOD_OK )
			trace("fmod err:" + fmodResultToString(fmodRes));
		else 
			trace("event list retrieved");
		return arrRes;
	}
	
	public static function showEventList( bnk : FmodStudioBankRef, cnt:Int )  {
		untyped __cpp__('
			FMOD::Studio::Bank * bank = {1};
			int nb = {0};
			FMOD::Studio::EventDescription ** arr = (FMOD::Studio::EventDescription ** ) malloc( cnt * sizeof(FMOD::Studio::EventDescription * ) );
			int nbDone = 0;
			bnk->getEventList(arr, nb, &nbDone);
			
			for ( int i = 0; i < nbDone;++i){
				char label[512];
				int strl = 0;
				arr[i]->getPath(label, 511, &strl);
				printf("%s\\n", label);
			}
			free(arr);
		',cnt, bnk);
	}
	
	@:extern
	public static inline function getMemoryAlign() : Int {
		return untyped __cpp__("FMOD_STUDIO_LOAD_MEMORY_ALIGNMENT");
	}
	
	public static function fmodResultToString( rs: FmodResult ){
		return 
		switch(rs){
			case FMOD_OK												: "FMOD_OK";
			case FMOD_ERR_BADCOMMAND									: "FMOD_ERR_BADCOMMAND";
			case FMOD_ERR_CHANNEL_ALLOC									: "FMOD_ERR_CHANNEL_ALLOC";
			case FMOD_ERR_CHANNEL_STOLEN								: "FMOD_ERR_CHANNEL_STOLEN";
			case FMOD_ERR_DMA											: "FMOD_ERR_DMA";
			case FMOD_ERR_DSP_CONNECTION								: "FMOD_ERR_DSP_CONNECTION";
			case FMOD_ERR_DSP_DONTPROCESS								: "FMOD_ERR_DSP_DONTPROCESS";
			case FMOD_ERR_DSP_FORMAT									: "FMOD_ERR_DSP_FORMAT";
			case FMOD_ERR_DSP_INUSE										: "FMOD_ERR_DSP_INUSE";
			case FMOD_ERR_DSP_NOTFOUND									: "FMOD_ERR_DSP_NOTFOUND";
			case FMOD_ERR_DSP_RESERVED									: "FMOD_ERR_DSP_RESERVED";
			
			case FMOD_ERR_DSP_SILENCE									: "FMOD_ERR_DSP_SILENCE";
			case FMOD_ERR_DSP_TYPE										: "FMOD_ERR_DSP_TYPE";
			case FMOD_ERR_FILE_BAD										: "FMOD_ERR_FILE_BAD";
			case FMOD_ERR_FILE_COULDNOTSEEK								: "FMOD_ERR_FILE_COULDNOTSEEK";
			case FMOD_ERR_FILE_DISKEJECTED								: "FMOD_ERR_FILE_DISKEJECTED";
			case FMOD_ERR_FILE_EOF										: "FMOD_ERR_FILE_EOF";
			case FMOD_ERR_FILE_ENDOFDATA								: "FMOD_ERR_FILE_ENDOFDATA";
			case FMOD_ERR_FILE_NOTFOUND									: "FMOD_ERR_FILE_NOTFOUND";
			case FMOD_ERR_FORMAT										: "FMOD_ERR_FORMAT";
			case FMOD_ERR_HEADER_MISMATCH								: "FMOD_ERR_HEADER_MISMATCH";
			case FMOD_ERR_HTTP											: "FMOD_ERR_HTTP";
			
			case FMOD_ERR_HTTP_ACCESS									: "FMOD_ERR_HTTP_ACCESS";
			case FMOD_ERR_HTTP_PROXY_AUTH								: "FMOD_ERR_HTTP_PROXY_AUTH";
			case FMOD_ERR_HTTP_SERVER_ERROR								: "FMOD_ERR_HTTP_SERVER_ERROR";
			case FMOD_ERR_HTTP_TIMEOUT									: "FMOD_ERR_HTTP_TIMEOUT";
			case FMOD_ERR_INITIALIZATION								: "FMOD_ERR_INITIALIZATION";
			case FMOD_ERR_INITIALIZED									: "FMOD_ERR_INITIALIZED";
			case FMOD_ERR_INTERNAL										: "FMOD_ERR_INTERNAL";
			case FMOD_ERR_INVALID_FLOAT									: "FMOD_ERR_INVALID_FLOAT";
			case FMOD_ERR_INVALID_HANDLE								: "FMOD_ERR_INVALID_HANDLE";
			case FMOD_ERR_INVALID_PARAM									: "FMOD_ERR_INVALID_PARAM";
			case FMOD_ERR_INVALID_POSITION								: "FMOD_ERR_INVALID_POSITION";
			
			case FMOD_ERR_INVALID_SPEAKER								: "FMOD_ERR_INVALID_SPEAKER";
			case FMOD_ERR_INVALID_SYNCPOINT								: "FMOD_ERR_INVALID_SYNCPOINT";
			case FMOD_ERR_INVALID_THREAD								: "FMOD_ERR_INVALID_THREAD";
			case FMOD_ERR_INVALID_VECTOR								: "FMOD_ERR_INVALID_VECTOR";
			case FMOD_ERR_MAXAUDIBLE									: "FMOD_ERR_MAXAUDIBLE";
			case FMOD_ERR_MEMORY										: "FMOD_ERR_MEMORY";
			case FMOD_ERR_MEMORY_CANTPOINT								: "FMOD_ERR_MEMORY_CANTPOINT";
			case FMOD_ERR_NEEDS3D										: "FMOD_ERR_NEEDS3D";
			case FMOD_ERR_NEEDSHARDWARE									: "FMOD_ERR_NEEDSHARDWARE";
			case FMOD_ERR_NET_CONNECT									: "FMOD_ERR_NET_CONNECT";
			case FMOD_ERR_NET_SOCKET_ERROR								: "FMOD_ERR_NET_SOCKET_ERROR";
			case FMOD_ERR_NET_URL										: "FMOD_ERR_NET_URL";
			case FMOD_ERR_NET_WOULD_BLOCK								: "FMOD_ERR_NET_WOULD_BLOCK";
			case FMOD_ERR_NOTREADY										: "FMOD_ERR_NOTREADY";
			case FMOD_ERR_OUTPUT_ALLOCATED								: "FMOD_ERR_OUTPUT_ALLOCATED";
			case FMOD_ERR_OUTPUT_CREATEBUFFER							: "FMOD_ERR_OUTPUT_CREATEBUFFER";
			case FMOD_ERR_OUTPUT_DRIVERCALL								: "FMOD_ERR_OUTPUT_DRIVERCALL";
			case FMOD_ERR_OUTPUT_FORMAT									: "FMOD_ERR_OUTPUT_FORMAT";
			case FMOD_ERR_OUTPUT_INIT									: "FMOD_ERR_OUTPUT_INIT";
			case FMOD_ERR_OUTPUT_NODRIVERS								: "FMOD_ERR_OUTPUT_NODRIVERS";
			case FMOD_ERR_PLUGIN										: "FMOD_ERR_PLUGIN";
			case FMOD_ERR_PLUGIN_MISSING								: "FMOD_ERR_PLUGIN_MISSING";
			case FMOD_ERR_PLUGIN_RESOURCE								: "FMOD_ERR_PLUGIN_RESOURCE";
			case FMOD_ERR_PLUGIN_VERSION								: "FMOD_ERR_PLUGIN_VERSION";
			case FMOD_ERR_RECORD										: "FMOD_ERR_RECORD";
			case FMOD_ERR_REVERB_CHANNELGROUP							: "FMOD_ERR_REVERB_CHANNELGROUP";
			case FMOD_ERR_REVERB_INSTANCE								: "FMOD_ERR_REVERB_INSTANCE";
			case FMOD_ERR_SUBSOUNDS										: "FMOD_ERR_SUBSOUNDS";
			case FMOD_ERR_SUBSOUND_ALLOCATED							: "FMOD_ERR_SUBSOUND_ALLOCATED";
			case FMOD_ERR_SUBSOUND_CANTMOVE								: "FMOD_ERR_SUBSOUND_CANTMOVE";
			case FMOD_ERR_TAGNOTFOUND									: "FMOD_ERR_TAGNOTFOUND";
			case FMOD_ERR_TOOMANYCHANNELS								: "FMOD_ERR_TOOMANYCHANNELS";
			case FMOD_ERR_TRUNCATED										: "FMOD_ERR_TRUNCATED";
			case FMOD_ERR_UNIMPLEMENTED									: "FMOD_ERR_UNIMPLEMENTED";
			case FMOD_ERR_UNINITIALIZED									: "FMOD_ERR_UNINITIALIZED";
			case FMOD_ERR_UNSUPPORTED									: "FMOD_ERR_UNSUPPORTED";
			case FMOD_ERR_VERSION										: "FMOD_ERR_VERSION";
			case FMOD_ERR_EVENT_ALREADY_LOADED							: "FMOD_ERR_EVENT_ALREADY_LOADED";
			case FMOD_ERR_EVENT_LIVEUPDATE_BUSY							: "FMOD_ERR_EVENT_LIVEUPDATE_BUSY";
			case FMOD_ERR_EVENT_LIVEUPDATE_MISMATCH						: "FMOD_ERR_EVENT_LIVEUPDATE_MISMATCH";
			case FMOD_ERR_EVENT_LIVEUPDATE_TIMEOUT						: "FMOD_ERR_EVENT_LIVEUPDATE_TIMEOUT";
			case FMOD_ERR_EVENT_NOTFOUND								: "FMOD_ERR_EVENT_NOTFOUND";
			case FMOD_ERR_STUDIO_UNINITIALIZED							: "FMOD_ERR_STUDIO_UNINITIALIZED";
			case FMOD_ERR_STUDIO_NOT_LOADED								: "FMOD_ERR_STUDIO_NOT_LOADED";
			case FMOD_ERR_INVALID_STRING								: "FMOD_ERR_INVALID_STRING";
			case FMOD_ERR_ALREADY_LOCKED								: "FMOD_ERR_ALREADY_LOCKED";
			case FMOD_ERR_NOT_LOCKED									: "FMOD_ERR_NOT_LOCKED";
			case FMOD_ERR_RECORD_DISCONNECTED							: "FMOD_ERR_RECORD_DISCONNECTED";
			case FMOD_ERR_TOOMANYSAMPLES								: "FMOD_ERR_TOOMANYSAMPLES";
		}
	}
}

@:keep
@:include('linc_faxe.h')
@:native("FMOD_CREATESOUNDEXINFO")
extern class FmodCreateSoundExInfo {
	
}


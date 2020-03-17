typedef Ptr<T> = cpp.Pointer<T>;
typedef RawPtr<T> = cpp.RawPointer<T>;

@:keep
class Cpp {

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
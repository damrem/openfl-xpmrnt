package hxlpers;
import msignal.Signal.Signal1;

/**
 * ...
 * @author damrem
 */
class SIntPool
{
	//static var sIntPool:Map<String, SInt> = new Map<String, SInt>();
	//static var signalPool:Map<String, Signal1<SInt>> = new Map<String, Signal1<SInt>>();
	
	public static function getSignal(user:SInt, k:String)//:Signal1<SInt>
	{
		//return pool.get(k);
	}
	
	public static function setSignal(user:SInt, k:String)
	{
		//sIntPool.set(k, user);
	}
	
	static public function init() 
	{
		//sIntPool = new Map<String, SInt>();
		//signalPool=new Map<String, Signal1<SInt>>();Lambda
	}
}
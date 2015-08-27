package hxlpers;



/**
 * ...
 * @author damrem
 */
class RndColor
{
	static public inline var FF:UInt = 0xFF;
	static inline var AABitShit:UInt = 32;
	static inline var RRBitShit:UInt = 16;
	static inline var GGBitShit:UInt = 8;
	static inline var BBBitShit:UInt = 0;
	
	static public function XX(bitShift:UInt, min:Float = 0, max:Float = 1):Int
	{
		var minComp = Std.int(min * FF);
		var maxComp = Std.int(max * FF);
		return Rnd.int(minComp, maxComp) << bitShift;
	}
	
	static public function AA(min:Float=0,max:Float=1):Int
	{
		return XX(AABitShit, min, max);
	}
	
	static public function RR(min:Float=0,max:Float=1):Int
	{
		return XX(RRBitShit, min, max);
	}
	
	static public function GG(min:Float=0,max:Float=1):Int
	{
		return XX(GGBitShit, min, max);
	}
	
	static public function BB(min:Float=0,max:Float=1):Int
	{
		return XX(BBBitShit, min, max);
	}
	
	static public function RRGGBB(min:Float=0,max:Float=1):UInt
	{
		return RR(min, max) + GG(min, max) + BB(min, max);
	}
	
	static public function AARRGGBB(min:Float=0,max:Float=1):UInt
	{
		return AA(min, max) + RRGGBB(min, max);
	}
	
}
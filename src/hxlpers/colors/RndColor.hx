package hxlpers.colors;



/**
 * ...
 * @author damrem
 */
class RndColor
{
	static public function XX(min:Float = 0, max:Float = 1, bitShift:UInt=0):Int
	{
		var minComp = Std.int(min * 0xFF);
		var maxComp = Std.int(max * 0xFF);
		return Rnd.int(minComp, maxComp) << bitShift;
	}
	
	static public function AA(min:Float=0,max:Float=1):Int
	{
		return XX(min, max, ColorComponent.ALPHA_BITSHIFT);
	}
	
	static public function RR(min:Float=0,max:Float=1):Int
	{
		return XX(min, max, ColorComponent.RED_BITSHIFT);
	}
	
	static public function GG(min:Float=0,max:Float=1):Int
	{
		return XX(min, max, ColorComponent.GREEN_BITSHIFT);
	}
	
	static public function BB(min:Float=0,max:Float=1):Int
	{
		return XX(min, max, ColorComponent.BLUE_BITSHIFT);
	}
	
	static public function RRGGBB(min:Float=0,max:Float=1):UInt
	{
		return RR(min, max) + GG(min, max) + BB(min, max);
	}
	
	static public function AARRGGBB(min:Float=0,max:Float=1):UInt
	{
		return AA(min, max) + RRGGBB(min, max);
	}
	
	static public function gray(min:Float = 0, max:Float = 1):UInt
	{
		var comp = XX(min, max);
		return (comp << ColorComponent.RED_BITSHIFT) + (comp << ColorComponent.GREEN_BITSHIFT) + (comp << ColorComponent.BLUE_BITSHIFT);
	}
	
}
package hxlpers.display;
import hxlpers.colors.ColorComponent;
import hxlpers.colors.RndColor;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import openfl.utils.ByteArray;

/**
 * ...
 * @author damrem
 */
class BitmapDataSF
{

	static public function simpleNoise(dt:BitmapData, density:Float=1, monochromatic:Bool=true, transparent:Bool=true):BitmapData
	{
		var w:UInt = cast(dt.width);
		var h:UInt = cast(dt.height);
		var pixels:ByteArray = new ByteArray();
		if (monochromatic && !transparent)
		{
			for (i in 0...w*h)
			{
				if (Rnd.chance(density))
				{
					pixels.writeUnsignedInt(ColorComponent.OPAQUE + RndColor.gray());
				}
				else
				{
					pixels.writeUnsignedInt(0);
				}
			}
		}
		else if(!monochromatic && transparent)
		{
			for (i in 0...w*h)
			{
				if (Rnd.chance(density))
				{
					pixels.writeUnsignedInt(RndColor.AA() + RndColor.RRGGBB());
				}
				else
				{
					pixels.writeUnsignedInt(0);
				}
			}
		}
		else if(monochromatic && transparent)
		{
			for (i in 0...w*h)
			{
				if (Rnd.chance(density))
				{
					pixels.writeUnsignedInt(RndColor.AA() + RndColor.gray());
				}
				else
				{
					pixels.writeUnsignedInt(0);
				}
			}
		}
		else if(!monochromatic && !transparent)
		{
			for (i in 0...w*h)
			{
				if (Rnd.chance(density))
				{
					pixels.writeUnsignedInt(ColorComponent.OPAQUE + RndColor.RRGGBB());
				}
				else
				{
					pixels.writeUnsignedInt(0);
				}
			}
		}
		
		pixels.position = 0;
		var zone = new Rectangle(0, 0, w, h);
		dt.setPixels(zone, pixels);
		return dt;
	}
	
}
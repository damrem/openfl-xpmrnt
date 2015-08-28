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

	static public function simpleNoise(dt:BitmapData, monochromatic:Bool=true)
	{
		var w:UInt = cast(dt.width);
		var h:UInt = cast(dt.height);
		var pixels:ByteArray = new ByteArray();
		if (monochromatic)
		{
			for (i in 0...w*h)
			{
				pixels.writeUnsignedInt(ColorComponent.OPAQUE + RndColor.gray());
			}
		}
		else
		{
			for (i in 0...w*h)
			{
				pixels.writeUnsignedInt(ColorComponent.OPAQUE + RndColor.RRGGBB());
			}
		}
		pixels.position = 0;
		var zone = new Rectangle(0, 0, w, h);
		dt.setPixels(zone, pixels);
		
	}
	
}
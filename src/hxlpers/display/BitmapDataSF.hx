package hxlpers.display;
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

	static public function simpleNoise(dt:BitmapData)
	{
		var w:UInt = cast(dt.width);
		var h:UInt = cast(dt.height);
		var pixels:ByteArray = new ByteArray();
		for (i in 0...w*h)
		{
			pixels.writeUnsignedInt(0xff0000+Rnd.int(0xffffff));
		}
		pixels.position = 0;
		var zone = new Rectangle(0, 0, w, h);
		dt.setPixels(zone, pixels);
		
	}
	
}
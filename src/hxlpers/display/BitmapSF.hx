package hxlpers.display;
import openfl.display.Bitmap;
using hxlpers.display.BitmapDataSF;
/**
 * ...
 * @author damrem
 */
class BitmapSF
{

	static public function simpleNoise(bmp:Bitmap):Bitmap
	{
		bmp.bitmapData.simpleNoise();
		return bmp;
	}
	
}
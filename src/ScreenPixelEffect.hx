package;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class ScreenPixelEffect extends Bitmap
{

	public function new(w:UInt, h:UInt, pixel:BitmapData) 
	{
		super();
		
		trace(w, h);
		
		var canvas = new Sprite();
		
		for (_y in 0...h)
		{
			for (_x in 0...w)
			{
				if (_x % pixel.width == 0 && _y % pixel.height == 0)
				{
					var px = new Bitmap(pixel);
					px.x = _x;
					px.y = _y;
					canvas.addChild(px);
				}
			}
		}
		
		var effectBuffer = new BitmapData(w, h, true, 0x00000000);
		effectBuffer.draw(canvas);
		
		bitmapData = effectBuffer;
	}
	
}
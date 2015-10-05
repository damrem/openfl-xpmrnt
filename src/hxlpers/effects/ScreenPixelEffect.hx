package hxlpers.effects;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.geom.Rectangle;

/**
 * ...
 * @author damrem
 */
class ScreenPixelEffect extends Bitmap
{

	public function new(pixel:BitmapData, ?zone:Rectangle) 
	{
		if (zone == null)
		{
			zone = Conf.VIEW_PORT;
		}
		
		var canvas = new Shape();
		canvas.graphics.beginBitmapFill(pixel);
		canvas.graphics.drawRect(zone.x, zone.y, zone.width, zone.height);
		canvas.graphics.endFill();
		
		var data = new BitmapData(Math.ceil(zone.width), Math.ceil(zone.height), true, 0x00000000);
		data.draw(canvas);
		super(data);
	}
	
}
package hxlpers.game;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.IBitmapDrawable;
import openfl.display.Sprite;
import openfl.geom.Rectangle;
import openfl.utils.ByteArray;
using hxlpers.display.BitmapDataSF;

/**
 * ...
 * @author damrem
 */
class Layer extends Sprite
{
	var bmp:Bitmap;
	

	public var scrollRatio:ScrollRatio;
	public var isMouseInteractive:Bool;
	public var isVisible:Bool;
	public var data:BitmapData;
	
	public function new(mouseInteractive:Bool=false, isVisible:Bool=true, ?zone:Rectangle) 
	{
		super();
		
		
		if (zone == null)
		{
			zone = new Rectangle(Conf.VIEW_PORT.x, Conf.VIEW_PORT.y, Conf.VIEW_PORT.width / Conf.PIXEL_SIZE, Conf.VIEW_PORT.height / Conf.PIXEL_SIZE);
		}
		this.data = new BitmapData(Math.ceil(zone.width), Math.ceil(zone.height), true, 0);
		this.isVisible = isVisible;
		this.isMouseInteractive = mouseInteractive;
		scrollRatio = {x:1, y:1};
	}
	
	public function getBitmap():Bitmap
	{
		if (bmp == null)
		{
			bmp = new Bitmap(data);
		}
		return bmp;
	}
	
	public function render():BitmapData
	{
		data.draw(this);
		return data;
	}
	
	public function getDrawable():IBitmapDrawable
	{
		return this;
	}
	
	public function getBytes(rerender:Bool=false):ByteArray
	{
		if (rerender)
		{
			render();
		}
		var _buffer = data.getPixels(data.rect);
		_buffer.position = 0;
		return _buffer;
	}
	
	
	
}

typedef ScrollRatio = {
	var x:Float;
	var y:Float;
}
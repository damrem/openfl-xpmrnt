package hxlpers.game;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.utils.ByteArray;

/**
 * ...
 * @author damrem
 */
class Layer extends Sprite
{

	public var scrollRatio:ScrollRatio;
	public var isMouseInteractive:Bool;
	public var isVisible:Bool;
	public var bitmapData:ColoredBitmapData;
	
	public function new(bitmapData:ColoredBitmapData, mouseInteractive:Bool=false, isVisible:Bool=true) 
	{
		super();
		this.bitmapData = bitmapData;
		this.isVisible = isVisible;
		this.isMouseInteractive = mouseInteractive;
		scrollRatio = {x:1, y:1};
	}
	
	public function render():BitmapData
	{
		bitmapData.fill();
		bitmapData.draw(this);
		return bitmapData;
	}
	
	public function getBytes(rerender:Bool=false):ByteArray
	{
		if (rerender)
		{
			render();
		}
		var _buffer = bitmapData.getPixels(bitmapData.rect);
		_buffer.position = 0;
		return _buffer;
	}
	
}

typedef ScrollRatio = {
	var x:Float;
	var y:Float;
}
package hxlpers.game;
import openfl.display.BitmapData;
import openfl.display.Sprite;
using hxlpers.display.BitmapDataSF;
/**
 * ...
 * @author damrem
 */
class Place extends Sprite
{
	var w:Float;
	var h:Float;
	var ratio:UInt;
	public var rendering:BitmapData;
	public function new(fullWidth:Float, fullHeight:Float, ratio:UInt)
	{
		super();
		w = fullWidth / ratio;
		h = fullHeight / ratio;
		this.ratio = ratio;
		rendering = new BitmapData(Math.ceil(w), Math.ceil(h));
	}
	
	public function update()
	{
		
	}
	
	public function play()
	{
		
	}
	
	public function pause()
	{
		
	}
	
	public function render()
	{
		rendering.clear();
		rendering.draw(this);
	}
	
}
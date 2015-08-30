package hxlpers.game;
import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class Place extends Sprite
{
	var w:Float;
	var h:Float;
	var ratio:UInt;
	public function new(fullWidth:Float, fullHeight:Float, ratio:UInt)
	{
		super();
		w = fullWidth / ratio;
		h = fullHeight / ratio;
		this.ratio = ratio;
		trace(w, h);
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
	
}
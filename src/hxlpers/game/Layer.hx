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
	
	public function new() 
	{
		super();
		scrollRatio = {x:1, y:1};
	}
	
	public function update()
	{
		//TODO update layer position according to the camera position and the scroll ratio
	}
	
}

typedef ScrollRatio = {
	var x:Float;
	var y:Float;
}
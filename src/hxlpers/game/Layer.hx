package hxlpers.game;
import openfl.display.Sprite;
import openfl.geom.Point;

/**
 * ...
 * @author damrem
 */
class Layer extends Sprite
{

	public var scrollRatio:ScrollRatio;
	
	public function new() 
	{
		scrollRatio = {x:1, y:1};
	}
	
}

typedef ScrollRatio = {
	var x:Float = 1;
	var y:Float = 1;
}
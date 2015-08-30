package halo;

import openfl.display.Shape;
import openfl.display.Sprite;
using hxlpers.display.ShapeSF;

/**
 * ...
 * @author damrem
 */
class Halo extends Sprite
{

	public function new(minRadius:Float, maxRadius:Float, intensity:Float=1.0) 
	{
		super();
		
		var external = new Shape();
		external.alpha = 0.5;
		external.disk(maxRadius);
		addChild(external);
		
		var intermediary = new Shape();
		intermediary.alpha = 0.75;
		intermediary.disk((minRadius + maxRadius) / 2);
		addChild(intermediary);
		
		var internal = new Shape();
		internal.alpha = 1;
		internal.disk(minRadius);
		addChild(internal);
		
	}
	
}
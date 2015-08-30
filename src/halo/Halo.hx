package halo;

import halo.Halo.HaloDiskDef;
import haxe.Constraints.Function;
import hxlpers.colors.Colors;
import openfl.display.Shape;
import openfl.display.Sprite;
using hxlpers.display.ShapeSF;

/**
 * ...
 * @author damrem
 */
class Halo extends Sprite
{

	var disks:Array<Shape>;
	
	public function new(defs:Array<HaloDiskDef>, color:UInt=Colors.WHITE) 
	{
		super();
		
		var disks = [];
		
		for (def in defs)
		{
			var disk = new Shape();
			disk.circle(def.radius, color);
			disk.alpha = def.intensity;
			disks.push(disk);
			addChild(disk);
		}
		
		
		
	}
	
	public function update()
	{
		
	}
	
}


typedef HaloDiskDef = {
	var intensity:Float;
	var radius:Float;
}
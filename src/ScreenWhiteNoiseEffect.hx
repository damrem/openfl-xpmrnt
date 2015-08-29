package;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.geom.Rectangle;


using hxlpers.display.BitmapDataSF;
/**
 * ...
 * @author damrem
 */
class ScreenWhiteNoiseEffect extends Sprite
{
	var pool:Array<Bitmap>;
	var current:Bitmap;
	var counter:UInt = 1;
	var currentId:UInt;
	var prevId:UInt;
	
	public function new(zone:Rectangle, population:UInt=10, noiseDensity:Float=0.25) 
	{
		super();
		pool = new Array<Bitmap>();
		
	
		for (i in 0...population)
		{
			pool.push(new Bitmap(new BitmapData(cast(zone.width), cast(zone.height), true, 0xffffffff).simpleNoise(noiseDensity)));
		}
		
		current = pool[0];
		addChild(current);
	}
	
	public function update(period:UInt=3)
	{
		counter++;
		
		if (counter % period == 0)
		{
			do
			{
				currentId = Std.random(pool.length);
			}
			while (currentId == prevId);
			prevId = currentId;
			removeChild(current);
			current = pool[currentId];
			addChild(current);
			counter = 1;
		}
	}
	
}
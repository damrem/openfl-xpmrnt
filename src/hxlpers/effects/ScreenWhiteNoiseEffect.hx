package hxlpers.effects;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.Event;
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
	var period:UInt;
	
	public function new(w:UInt, h:UInt, population:UInt=10, density:Float=0.25, period:UInt=3) 
	{
		super();
		this.period = period;
		pool = new Array<Bitmap>();
		
	
		for (i in 0...population)
		{
			pool.push(new Bitmap(new BitmapData(w, h, true, 0xffffffff).simpleNoise(density)));
		}
		
		current = pool[0];
		addChild(current);
		
		mouseEnabled = false;

		addEventListener(Event.ENTER_FRAME, update);
		
	}
	
	public function update(evt:Event=null)
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
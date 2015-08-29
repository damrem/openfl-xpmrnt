package;

import haxe.ds.IntMap;
import hxlpers.shapes.BoxShape;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Point;

/**
 * ...
 * @author damrem
 */
class MultiGraph extends Sprite
{
	var w:Float = 0.25;
	var pts:Array<Point>;
	
	
	public function new() 
	{
		super();
		pts = new Array<Point>();
		addEventListener(Event.ADDED_TO_STAGE, onStage);
	}
	
	private function onStage(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onStage);
		
		var graph = new Sprite();
		
		//var ax:Float = 0, ay:Float = stage.stageHeight;
		var x:Float=0, y:Float=stage.stageHeight;
		
		// Assets:
		// openfl.Assets.getBitmapData("img/assetname.jpg");
		var prevN:UInt = 0;
		var already:IntMap<Bool> = new IntMap<Bool>();
		
		for (i in 1...cast(640/w+1))
		{
			var n:UInt=0;
			for (j in 1...i+1)
			{
				if (i % j == 0) n++;
			}
			
			
			//trace('${i}:${n}');
			
			var pt = new Point(x, y);
			
			//trace(already);
			var bar = new BoxShape(w, n * 10, already.exists(n) ? 0xff0000:0xffffff);
			bar.x = i * w;
			bar.y = stage.stageHeight - n * 10;	
			graph.addChild(bar);
			
			already.set(n, true);
		}
		
		var graphRender = new BitmapData(640, 480);
		graphRender.draw(graph);
		var graphScreen = new Bitmap(graphRender);
		addChild(graphScreen);
		
		
		
	}
	
}
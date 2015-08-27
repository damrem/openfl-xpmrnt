package;



import haxe.ds.IntMap;
import hxlpers.RndColor;
import hxlpers.Rnd;
import hxlpers.shapes.DiskShape;
import hxlpers.shapes.BoxShape;
import hxlpers.shapes.SegmentShape;
import hxlpers.shapes.ShortcutShape;
import msignal.Signal.Signal1;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.BlendMode;
import openfl.display.FPS;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.filters.GlowFilter;
import openfl.geom.ColorTransform;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.Lib;

/**
 * ...
 * @author damrem
 */
class Main extends Sprite 
{

	var pts:Array<Point>;
	var w:Float = 0.25;
	var ratio:Float;
	var scene:Sprite;
	var shapes:Array<Shape>;
	var buffer:openfl.display.BitmapData;
	var vp:flash.geom.Rectangle;
	var nbShapes:UInt = 100;
	var colorShift:Int;
	
	public function new() 
	{
		super();
		
		trace(0xff<<8);
		trace(0xff00);
		trace(0xff0000);
		
		
		addEventListener(Event.ADDED_TO_STAGE, onStage);
		
		//addChild(scene);
	}
	
	private function onStage(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onStage);
		
		ratio = 4;
		
		buffer = new BitmapData(cast(stage.stageWidth / ratio), cast(stage.stageHeight / ratio), false, 0);
		
		vp = new flash.geom.Rectangle(0, 0, stage.stageWidth / ratio, stage.stageHeight / ratio);
		
		var screen = new Bitmap(buffer);
		screen.width *= ratio;
		screen.height *= ratio;
		addChild(screen);
		
		var pxFx = Assets.getBitmapData("img/px-fx.png");
		var effect = new Sprite();
		effect.alpha = 0.125;
		
		//var fxZone = new Rectangle(0, 0, 4, 4);
		//var ct = new ColorTransform();
		for (_y in 0...buffer.height)
		{
			for (_x in 0...buffer.width)
			{
				//position.x = _x;
				//position.y = _y;
				
				//var ct = new ColorTransform(0.75 + Math.random() * 0.5, 0.75 + Math.random() * 0.5, 0.75 + Math.random() * 0.5);
				//var _position = new Rectangle(_x, _y, 4, 4);
				var fx = new Bitmap(pxFx);
				fx.alpha = Rnd.float(0.4,0.6);
				//fx.bitmapData.colorTransform(fxZone, ct);
				fx.x = _x*ratio;
				fx.y = _y*ratio;
				
				effect.addChild(fx);
				//render.draw(pxFx, null, ct, BlendMode.MULTIPLY, _position, false);
			}
		}
		var effectBuffer = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0x00000000);
		effectBuffer.draw(effect);
		var effectScreen = new Bitmap(effectBuffer);
		addChild(effectScreen);
		
		addChild(new FPS(10, 10, 0xffffff));
		
		scene = new Sprite();
		
		
		shapes = new Array<Shape>();
		
		for (i in 0...nbShapes)
		{
			var size = Math.random() * 10;
			//var color = RndColor.RR(0, 0.25)+RndColor.GG(0.5,1)+RndColor.BB(0.25, 0.5);
			var color = RndColor.RRGGBB(0.25, 0.5);
			//trace(color);
			var shape:ShortcutShape;
			if (Rnd.chance())
			{
				shape = new DiskShape(size, color);
			}
			else
			{
				shape = new BoxShape(size, size, color);
				shape.rotation = Math.random() * 360;
			}
			shape.alpha = Math.random();
			shape.x = Math.random() * stage.stageWidth / ratio;
			shape.y = Math.random() * stage.stageHeight / ratio;
			
			scene.addChild(shape);
			shapes.push(shape);
		}
		
		addEventListener(Event.ENTER_FRAME, update);
	}
	
	
	public function render()
	{
		
		
		//render.applyFilter(render, new flash.geom.Rectangle(0, 0, render.width, render.height), new Point(0,0), new GlowFilter(0xff0000));
		//var position:Rectangle;
		
		buffer.fillRect(vp, 0);
		buffer.draw(scene);
		
		//TODO very costly: instead, pre-generate a dozen of noisy full layers and cycle randomly trough them
		for (_y in 0...buffer.height)
		{
			for (_x in 0...buffer.width)
			{
				colorShift = RndColor.RR(0,0.05) + RndColor.GG(0, 0.05) + RndColor.BB(0, 0.05);
				buffer.setPixel(_x, _y, buffer.getPixel(_x, _y) + colorShift);
			}
		}
		//render.draw(effect);
		
		
		
		
		
	}
	
	function resolve()
	{
		for (shape in shapes)
		{
			shape.x += Rnd.float( -1, 1);
			shape.y += Rnd.float( -1, 1);
			shape.alpha += Rnd.float( -0.1, 0.1);
			shape.rotation += Rnd.float( -5, 5);
		}
	}
	
	
	function update(evt:Event = null)
	{
		resolve();
		render();
	}
	
		
		
	function drawGraph()
	{
		
		
		var graph = new Sprite();
		
		pts = new Array<Point>();
		
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
		
		
		
		var scene = new Sprite();
		
		
	}

}


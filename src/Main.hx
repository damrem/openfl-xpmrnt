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
import openfl.utils.ByteArray;

/**
 * ...
 * @author damrem
 */
class Main extends Sprite 
{

	var pts:Array<Point>;
	var w:Float = 0.25;
	var RATIO:Float = 4;
	var scene:Sprite;
	var shapes:Array<Shape>;
	var buffer:openfl.display.BitmapData;
	var renderZone:flash.geom.Rectangle;
	var nbShapes:UInt = 100;
	var colorShift:Int;
	
	var foreScreens:Array<Bitmap>;
	var nbForeScreens:UInt = 100;
	var currentForeScreen:Bitmap;
	var foreScreenContainer:openfl.display.Sprite;
	
	public function new() 
	{
		super();
		
		addEventListener(Event.ADDED_TO_STAGE, onStage);
		foreScreens=new Array<Bitmap>();
		//addChild(scene);
	}
	
	function createForeScreen(zone:Rectangle):Bitmap
	{
		var w:UInt = cast(zone.width);
		var h:UInt = cast(zone.height);
		var bfr:BitmapData = new BitmapData(w, h, false, 0);
		var pixels:ByteArray = new ByteArray();
		for (i in 0...w*h)
		{
			pixels.writeUnsignedInt(0xff0000+Rnd.int(0xffffff));
		}
		pixels.position = 0;
		bfr.setPixels(zone, pixels);
		
		
		return new Bitmap(bfr);
		
	}
	
	
	function createForeScreens(Length:UInt):Array<Bitmap>
	{
		var foreScreens = new Array<Bitmap>();
		for (i in 0...Length)
		{
			var foreScreen = createForeScreen(renderZone);
			foreScreen.alpha = 0.05;
			foreScreen.width *= RATIO;
			foreScreen.height *= RATIO;
			foreScreens.push(foreScreen);
		}
		return foreScreens;
	}
	
	private function onStage(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onStage);
		
		buffer = new BitmapData(cast(stage.stageWidth / RATIO), cast(stage.stageHeight / RATIO), false, 0);
		
		renderZone = new flash.geom.Rectangle(0, 0, stage.stageWidth / RATIO, stage.stageHeight / RATIO);
		
		var screen = new Bitmap(buffer);
		screen.width *= RATIO;
		screen.height *= RATIO;
		addChild(screen);
		
		var pxFx = Assets.getBitmapData("img/px-fx3.png");
		var effect = new Sprite();
		effect.alpha = 0.125;
		
		foreScreens = createForeScreens(nbForeScreens);
		foreScreenContainer = new Sprite();
		currentForeScreen = foreScreens[0];
		addChild(foreScreenContainer);
		foreScreenContainer.addChild(currentForeScreen);
		//foreScreenContainer.addChild(foreScreens[1]);
		//foreScreens[1].x = 170;
		
		
		
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
				fx.alpha = 0.25;
				//fx.bitmapData.colorTransform(fxZone, ct);
				fx.x = _x*RATIO;
				fx.y = _y*RATIO;
				
				effect.addChild(fx);
				//render.draw(pxFx, null, ct, BlendMode.MULTIPLY, _position, false);
			}
		}
		
		var effectBuffer = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0x00000000);
		effectBuffer.draw(effect);
		var effectScreen = new Bitmap(effectBuffer);
		addChild(effectScreen);
		
		
		
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
			shape.x = Math.random() * stage.stageWidth / RATIO;
			shape.y = Math.random() * stage.stageHeight / RATIO;
			
			scene.addChild(shape);
			shapes.push(shape);
		}
		
		//addChild(createForeScreen(renderZone));
		addEventListener(Event.ENTER_FRAME, update);
		
		addChild(new FPS(10, 10, 0xffffff));
		
	}
	
	
	public function render()
	{
		
		
		buffer.fillRect(renderZone, 0);
		buffer.draw(scene);
		
		
		foreScreenContainer.removeChild(currentForeScreen);
		currentForeScreen = foreScreens[Std.random(foreScreens.length)];
		foreScreenContainer.addChild(currentForeScreen);
		
		//TODO very costly: instead, pre-generate a dozen of noisy full layers and cycle randomly trough them
		/*for (_y in 0...buffer.height)
		{
			for (_x in 0...buffer.width)
			{
				colorShift = RndColor.RR(0,0.05) + RndColor.GG(0, 0.05) + RndColor.BB(0, 0.05);
				buffer.setPixel(_x, _y, buffer.getPixel(_x, _y) + colorShift);
			}
		}
		*/
		
		
		//render.draw(effect);
		
		
		
		
		
	}
	
	
	
	function resolve()
	{
		for (shape in shapes)
		{
			if (Rnd.chance(0.01))
			{
				shape.x += Rnd.float( -1, 1);
				shape.y += Rnd.float( -1, 1);
				shape.alpha += Rnd.float( -0.1, 0.1);
				shape.rotation += Rnd.float( -5, 5);
			}
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


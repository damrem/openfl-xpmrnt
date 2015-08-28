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
import openfl.events.MouseEvent;
import openfl.filters.GlowFilter;
import openfl.geom.ColorTransform;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.Lib;
import openfl.utils.ByteArray;

using hxlpers.display.BitmapDataSF;

/**
 * ...
 * @author damrem
 */
class Main extends Sprite 
{

	var pts:Array<Point>;
	static inline var RATIO:Float = 4;
	var scene:Sprite;
	var entities:Array<Sprite>;
	var buffer:openfl.display.BitmapData;
	var renderZone:flash.geom.Rectangle;
	var nbShapes:UInt = 100;
	var colorShift:Int;
	
	var foreScreens:Array<Bitmap>;
	static inline var NOISE_POP:UInt = 100;
	var currentForeScreen:Bitmap;
	var foreScreenContainer:openfl.display.Sprite;
	
	public function new() 
	{
		super();
		
		addEventListener(Event.ADDED_TO_STAGE, onStage);
		foreScreens=new Array<Bitmap>();
		//addChild(scene);
	}
	
	
	
	
	function createForeScreens(Length:UInt):Array<Bitmap>
	{
		var foreScreens = new Array<Bitmap>();
		for (i in 0...Length)
		{
			var dt = new BitmapData(cast(renderZone.width), cast(renderZone.height), false, 0xffffffff);
			dt.simpleNoise();
			
			var foreScreen = new Bitmap(dt);
			foreScreen.alpha = 0.05;
			foreScreen.width *= RATIO;
			foreScreen.height *= RATIO;
			foreScreens.push(foreScreen);
		}
		return foreScreens;
	}
	
	function createTiles():Bitmap
	{
		var pxFx = Assets.getBitmapData("img/px-fx3.png");
		var effect = new Sprite();
		effect.alpha = 0.125;
		
		for (_y in 0...buffer.height)
		{
			for (_x in 0...buffer.width)
			{
				var fx = new Bitmap(pxFx);
				fx.alpha = 0.25;
				fx.x = _x*RATIO;
				fx.y = _y*RATIO;
				effect.addChild(fx);
			}
		}
		
		var effectBuffer = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0x00000000);
		effectBuffer.draw(effect);
		return new Bitmap(effectBuffer);
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
		
		foreScreens = createForeScreens(NOISE_POP);
		foreScreenContainer = new Sprite();
		currentForeScreen = foreScreens[0];
		addChild(foreScreenContainer);
		foreScreenContainer.addChild(currentForeScreen);
		
		
		
		
		
		addChild(createTiles());
		
		
		
		
		
		scene = new Sprite();
		
		
		entities = new Array<Sprite>();
		
		for (i in 0...nbShapes)
		{
			var size = Math.random() * 10;
			//var color = RndColor.RR(0, 0.25)+RndColor.GG(0.5,1)+RndColor.BB(0.25, 0.5);
			var color = RndColor.RRGGBB(0.25, 0.5);
			//trace(color);
			var shape:ShortcutShape;
			var sprite = new Sprite();
			
			if (Rnd.chance())
			{
				shape = new DiskShape(size, color);
			}
			else
			{
				shape = new BoxShape(size, size, color);
				shape.rotation = Math.random() * 360;
			}
			sprite.addChild(shape);
			sprite.alpha = Math.random();
			sprite.x = Math.random() * stage.stageWidth / RATIO;
			sprite.y = Math.random() * stage.stageHeight / RATIO;
			sprite.buttonMode = true;
			sprite.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			
			
			scene.addChild(sprite);
			entities.push(sprite);
		}
		
		var logicalScene = new Sprite();
		logicalScene.addChild(scene);
		logicalScene.alpha = 0;
		logicalScene.scaleX = logicalScene.scaleY = RATIO;
		addChild(logicalScene);
		
		
		//addChild(createForeScreen(renderZone));
		addEventListener(Event.ENTER_FRAME, update);
		
		addChild(new FPS(10, 10, 0xffffff));
		
	}
	
	private function onRollOver(e:MouseEvent):Void 
	{
		
		cast(e.currentTarget, Sprite).alpha = 1;
	}
	
	
	public function render()
	{
		
		
		buffer.fillRect(renderZone, 0);
		buffer.draw(scene);
		
		
		/*
		foreScreenContainer.removeChild(currentForeScreen);
		currentForeScreen = foreScreens[Std.random(foreScreens.length)];
		foreScreenContainer.addChild(currentForeScreen);
		*/
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
		for (shape in entities)
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
	
		
		
	

}


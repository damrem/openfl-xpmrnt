package;



import hxlpers.colors.ColorComponent;
import hxlpers.colors.RndColor;
import hxlpers.effects.ScreenPixelEffect;
import hxlpers.effects.ScreenWhiteNoiseEffect;
import hxlpers.Rnd;
import hxlpers.shapes.BoxShape;
import hxlpers.shapes.DiskShape;
import hxlpers.shapes.ShortcutShape;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Point;
import openfl.geom.Rectangle;

using hxlpers.display.DisplayObjectSF;
using hxlpers.display.BitmapDataSF;
/**
 * ...
 * @author damrem
 */
class Main extends Sprite 
{
	static public inline var NOISE_ALPHA:Float = 0.05;

	var pts:Array<Point>;
	static inline var RATIO:Float = 3;
	var scene:Sprite;
	var entities:Array<Sprite>;
	var buffer:BitmapData;
	var renderZone:Rectangle;
	var nbShapes:UInt = 100;
	var colorShift:Int;
	
	var noiseEffect:hxlpers.effects.ScreenWhiteNoiseEffect;
	
	
	public function new() 
	{
		super();
		
		addEventListener(Event.ADDED_TO_STAGE, onStage);
	}
	
	
	
	
	
	
	private function onStage(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onStage);
		
		var w = stage.stageWidth / RATIO;
		var h = stage.stageHeight / RATIO;
		
		buffer = new BitmapData(cast(w), cast(h), false, 0);
		
		renderZone = new Rectangle(0, 0, w, h);
		
		var screen = new Bitmap(buffer);
		screen.scale(RATIO);
		addChild(screen);
		
		noiseEffect = new hxlpers.effects.ScreenWhiteNoiseEffect(renderZone);
		noiseEffect.scale(RATIO);
		noiseEffect.alpha = NOISE_ALPHA;
		addChild(noiseEffect);
		
		var pxFx = new hxlpers.effects.ScreenPixelEffect(stage.stageWidth, stage.stageHeight, Assets.getBitmapData("img/px3-2.png"));
		pxFx.alpha = 0.125;
		addChild(pxFx);
		
		
		
		
		
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
		buffer.clear();
		buffer.draw(scene);
		
		noiseEffect.update();
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


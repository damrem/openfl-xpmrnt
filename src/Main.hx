package;



import hxlpers.colors.RndColor;
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
	var buffer:openfl.display.BitmapData;
	var renderZone:flash.geom.Rectangle;
	var nbShapes:UInt = 100;
	var colorShift:Int;
	
	var noiseEffect:ScreenWhiteNoiseEffect;
	
	
	public function new() 
	{
		super();
		
		addEventListener(Event.ADDED_TO_STAGE, onStage);
	}
	
	
	
	
	
	
	private function onStage(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onStage);
		
		buffer = new BitmapData(cast(stage.stageWidth / RATIO), cast(stage.stageHeight / RATIO), false, 0);
		
		renderZone = new flash.geom.Rectangle(0, 0, stage.stageWidth / RATIO, stage.stageHeight / RATIO);
		
		var screen = new Bitmap(buffer);
		screen.scale(RATIO);
		addChild(screen);
		
		noiseEffect = new ScreenWhiteNoiseEffect(renderZone);
		noiseEffect.scale(RATIO);
		noiseEffect.alpha = NOISE_ALPHA;
		addChild(noiseEffect);
		
		var pxFx = new ScreenPixelEffect(stage.stageWidth, stage.stageHeight, Assets.getBitmapData("img/px3-2.png"));
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
		
		
		buffer.fillRect(renderZone, 0);
		buffer.draw(scene);
		
		noiseEffect.update();
		
		
		
		
		
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


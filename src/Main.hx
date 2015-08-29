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
	static inline var NOISE_ALPHA:Float = 0.05;
	static inline var RATIO:Float = 3;

	var buffer:BitmapData;
	var renderZone:Rectangle;
	
	var noiseEffect:ScreenWhiteNoiseEffect;
	var world:MiniWorld;
	
	
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
		
		var pxFx = new ScreenPixelEffect(stage.stageWidth, stage.stageHeight, Assets.getBitmapData("img/px3-2.png"));
		pxFx.alpha = 0.125;
		addChild(pxFx);
		
		
		
		
		
		world = new MiniWorld(w, h);
		
		
		
		var logicalScene = new Sprite();
		logicalScene.addChild(world.scene);
		logicalScene.alpha = 0;
		logicalScene.scaleX = logicalScene.scaleY = RATIO;
		addChild(logicalScene);
		
		
		//addChild(createForeScreen(renderZone));
		addEventListener(Event.ENTER_FRAME, update);
		
		addChild(new FPS(10, 10, 0xffffff));
		
	}
	
	
	
	
	public function render()
	{
		buffer.clear();
		buffer.draw(world.scene);
		
		noiseEffect.update();
	}
	
	
	
	
	
	
	function update(evt:Event = null)
	{
		world.update();
		render();
	}
	
		
		
	

}


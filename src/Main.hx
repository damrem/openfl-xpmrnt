package;



import hxlpers.colors.ColorComponent;
import hxlpers.colors.RndColor;
import hxlpers.effects.ScreenPixelEffect;
import hxlpers.effects.ScreenWhiteNoiseEffect;
import hxlpers.game.Game;
import hxlpers.game.Place;
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
	static inline var RATIO:UInt = 3;

	
	
	var noiseEffect:ScreenWhiteNoiseEffect;
	var place:Place;
	
	
	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, onStage);
	}
	
	
	private function onStage(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onStage);
		
		//var w = stage.stageWidth / RATIO;
		//var h = stage.stageHeight / RATIO;
		
		var game = new Game(stage.stageWidth, stage.stageHeight, RATIO);
		addChild(game);
		
		place = new OtherPlace(stage.stageWidth/RATIO, stage.stageHeight/RATIO, RATIO);
		game.addPlace('other', place);
		
		place = new OnePlace(stage.stageWidth/RATIO, stage.stageHeight/RATIO);
		//game.addPlace('one', place);
		
		/*
		noiseEffect = new ScreenWhiteNoiseEffect(stage.stageWidth, stage.stageHeight);
		noiseEffect.scale(RATIO);
		noiseEffect.alpha = NOISE_ALPHA;
		
		addChild(noiseEffect);
		*/
		
		var pxFx = new ScreenPixelEffect(stage.stageWidth, stage.stageHeight, Assets.getBitmapData("img/px3-2.png"));
		pxFx.alpha = 0.125;
		addChild(pxFx);
		
		addChild(new FPS(10, 10, 0xffffff));
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
		
		
	

}


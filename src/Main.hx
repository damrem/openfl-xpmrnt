package;



import entities.EntityPlace;
import hxlpers.effects.ScreenPixelEffect;
import hxlpers.effects.ScreenWhiteNoiseEffect;
import hxlpers.game.Game;
import hxlpers.game.Place;
import openfl.Assets;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;

using hxlpers.display.DisplayObjectSF;
using hxlpers.display.BitmapDataSF;
using hxlpers.effects.BitmapDataPixelEffectSF;
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
		
		
		//game.addPlace("other", new OtherPlace(stage.stageWidth, stage.stageHeight, RATIO));
		//game.addPlace("one", new OnePlace(stage.stageWidth, stage.stageHeight, RATIO));
		//game.addPlace("walking", new walking.WalkingPlace(stage.stageWidth, stage.stageHeight, RATIO));
		//game.addPlace("tilesheet", new TileSheetPlace(stage.stageWidth, stage.stageHeight, 3));
		//game.addPlace("masked", new halo.HaloPlace(stage.stageWidth, stage.stageHeight, 3));
		
		var entityPlace = new EntityPlace(stage.stageWidth, stage.stageHeight, 3);
		game.addPlace("entities", entityPlace);
		
		noiseEffect = new ScreenWhiteNoiseEffect(stage.stageWidth, stage.stageHeight, 1);
		noiseEffect.scale(RATIO);
		noiseEffect.alpha = NOISE_ALPHA;
		
		
		
		addChild(noiseEffect);
		
		//addChild(entityPlace.phyDebugSprite);
		
		
		var pxFx = new ScreenPixelEffect(stage.stageWidth, stage.stageHeight, Assets.getBitmapData("img/px3-3.png"));
		pxFx.alpha = 0.125;
		addChild(pxFx);
		
		
		
		addChild(new FPS(10, 10, 0xffffff));
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
		
		
	

}


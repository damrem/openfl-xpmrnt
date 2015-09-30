package;



import entities.EntityPlace;
import halo.HaloRoom;
import hxlpers.effects.ScreenPixelEffect;
import hxlpers.effects.ScreenWhiteNoiseEffect;
import hxlpers.game.Game;
import hxlpers.game.Room;
import hxlpers.shapes.ShortcutShape;
import openfl.Assets;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import svganimation.SvgAnimationRoom;
import tiledbox2d.TiledBox2dRoom;
import tiledbox2d.TiledBox2dRoom;
import tiledbox2d.TiledBox2dRoom;
import tiledbox2d.TiledBox2dRoom;
import tiledbox2d.TiledBox2dRoom;

using hxlpers.display.DisplayObjectSF;
using hxlpers.display.SpriteSF;
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
	var place:Room;
	
	
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
		
		
		//game.addRoom("other", new OtherPlace(stage.stageWidth, stage.stageHeight, RATIO));
		game.addRoom("one", new OnePlace(stage.stageWidth, stage.stageHeight, RATIO));
		//game.addRoom("walking", new walking.WalkingRoom(stage.stageWidth, stage.stageHeight, RATIO));
		//game.addRoom("tilesheet", new TileSheetPlace(stage.stageWidth, stage.stageHeight, 3));
		//game.addRoom("masked", new HaloRoom(stage.stageWidth, stage.stageHeight, 3));
		
		//var entityPlace = new EntityPlace(stage.stageWidth, stage.stageHeight, 3);
		//game.addRoom("entities", entityPlace);
		
		/*
		var tiledBox2dRoom = new TiledBox2dRoom(stage.stageWidth, stage.stageHeight, RATIO);
		game.addRoom("tiledbox2d", tiledBox2dRoom);
		*/
		
		//game.addRoom("svgAnimation", new SvgAnimationRoom(stage.stageWidth, stage.stageHeight, RATIO));
		
		noiseEffect = new ScreenWhiteNoiseEffect(stage.stageWidth, stage.stageHeight, 1);
		noiseEffect.scale(RATIO);
		noiseEffect.alpha = NOISE_ALPHA;
		
		
		
		addChild(noiseEffect);
		
		
		var pxFx = new ScreenPixelEffect(stage.stageWidth, stage.stageHeight, Assets.getBitmapData("img/px3-3.png"));
		pxFx.alpha = 0.125;
		addChild(pxFx);
		
		//addChild(entityPlace.phyDebugSprite);
		//addChild(tiledBox2dRoom.worldDebug);
		//tiledBox2dRoom.worldDebug.alpha = 0.25;
		
		
		addChild(new FPS(10, 10, 0xffffff));
		
	}
	

}


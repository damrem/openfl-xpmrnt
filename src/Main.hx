package;



import halo.HaloRoom;
import hxlpers.effects.ScreenPixelEffect;
import hxlpers.effects.ScreenWhiteNoiseEffect;
import hxlpers.game.Game;
import hxlpers.game.Room;
import openfl.Assets;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Rectangle;
import walking.WalkingRoom;

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
		
		Conf.PIXEL_SIZE = 3;
		
	}
	
	
	private function onStage(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onStage);
		
		Conf.VIEW_PORT = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
		
		//var w = stage.stageWidth / RATIO;
		//var h = stage.stageHeight / RATIO;
		
		var game = new Game();
		addChild(game);
		
		
		game.addRoom("one", new OneRoom());
		//game.addRoom("other", new OtherRoom(stage.stageWidth, stage.stageHeight, RATIO));
		//game.addRoom("walking", new WalkingRoom(stage.stageWidth, stage.stageHeight, RATIO));
		//game.addRoom("tilesheet", new TileSheetPlace(stage.stageWidth, stage.stageHeight, RATIO));
		//game.addRoom("masked", new HaloRoom(stage.stageWidth, stage.stageHeight, RATIO));
		
		//var entityPlace = new EntityPlace(stage.stageWidth, stage.stageHeight, RATIO);
		//game.addRoom("entities", entityPlace);
		
		/*
		var tiledBox2dRoom = new TiledBox2dRoom(stage.stageWidth, stage.stageHeight, RATIO);
		game.addRoom("tiledbox2d", tiledBox2dRoom);
		*/
		
		//game.addRoom("svgAnimation", new SvgAnimationRoom(stage.stageWidth, stage.stageHeight, RATIO));
		
		noiseEffect = new ScreenWhiteNoiseEffect(1);
		noiseEffect.scale(RATIO);
		noiseEffect.alpha = NOISE_ALPHA;
		
		
		
		addChild(noiseEffect);
		
		
		var pxFx = new ScreenPixelEffect(Assets.getBitmapData("img/px3-3.png"));
		pxFx.alpha = 0.125;
		addChild(pxFx);
		
		//addChild(entityPlace.phyDebugSprite);
		//addChild(tiledBox2dRoom.worldDebug);
		//tiledBox2dRoom.worldDebug.alpha = 0.25;
		
		
		addChild(new FPS(10, 10, 0xffffff));
		
	}
	

}


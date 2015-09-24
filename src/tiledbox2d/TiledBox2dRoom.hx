package tiledbox2d;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2World;
import haxe.Json;
import hxlpers.game.Place;
import hxlpers.tiled.TileMapBitmapData;
import hxlpers.tiled.TileMapDef;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.geom.Matrix;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import tiledbox2d.PhyTileMap;
using hxlpers.display.SpriteSF;

/**
 * ...
 * @author damrem
 */
class TiledBox2dRoom extends Place
{
	public var worldDebug:Sprite;

	public function new(fullWidth:Float, fullHeight:Float, ratio:UInt) 
	{
		super(fullWidth, fullHeight, ratio);
		
		var tileSetBitmapData = Assets.getBitmapData("img/bugtilesbrown.png");
		var dt:TileMapDef = new TileMapDef(Json.parse(Assets.getText("lvl/ring.json")));
		var tileMap = new TileMapBitmapData(dt, tileSetBitmapData);
		
		addChild(new Bitmap(tileMap));
		
		var world = new B2World(new B2Vec2(), true);
		var bodyCreator = new BodyCreator(world);
		var phyTileMap = new PhyTileMap(dt, bodyCreator);
		
		worldDebug = new Sprite();
		var debugDraw = new B2DebugDraw();
		debugDraw.setFlags(
			B2DebugDraw.e_aabbBit | 
			B2DebugDraw.e_centerOfMassBit | 
			B2DebugDraw.e_controllerBit | 
			B2DebugDraw.e_jointBit | 
			B2DebugDraw.e_pairBit | 
			B2DebugDraw.e_shapeBit
		);
		debugDraw.setDrawScale(cast(ratio));
		debugDraw.setSprite(worldDebug);
		world.setDebugDraw(debugDraw);
		world.drawDebugData();
		//var bodyDef = new B2BodyDef();
		
		//world.createBody(
		//rect(50, 50);
		
	}
	
}
package;

import haxe.Json;
import hxlpers.game.Room;
import hxlpers.tiled.TileMapBitmapData;
import hxlpers.tiled.TileMapDef;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.geom.Matrix;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * ...
 * @author damrem
 */
class TileSheetPlace extends Room
{

	public function new(fullWidth:Float, fullHeight:Float, ratio:UInt) 
	{
		super(fullWidth, fullHeight, ratio);
		
		var tileSetBitmapData = Assets.getBitmapData("img/bugtilesbrown.png");
		var dt:TileMapDef = new TileMapDef(Json.parse(Assets.getText("lvl/ring.json")));
		var tileMap = new TileMapBitmapData(dt, tileSetBitmapData);
		
		addChild(new Bitmap(tileMap));
		
		
	}
	
}
package;

import haxe.Json;
import hxlpers.game.Layer;
import hxlpers.game.Room;
import hxlpers.tiled.TileMapBitmapData;
import hxlpers.tiled.TileMapDef;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.geom.Matrix;
import openfl.geom.Point;
import openfl.geom.Rectangle;
using hxlpers.display.DisplayObjectSF;

/**
 * ...
 * @author damrem
 */
class TileSheetPlace extends Room
{

	public function new() 
	{
		super();
		
		var tileSetBitmapData = Assets.getBitmapData("img/bugtilesbrown.png");
		var dt:TileMapDef = new TileMapDef(Json.parse(Assets.getText("lvl/ring.json")), "lvl/");
		var tileMap = new TileMapBitmapData(dt, tileSetBitmapData);
		
		var mainLayer = new Layer();
		var bmp = new Bitmap(tileMap);
		bmp.scale(Conf.PIXEL_SIZE);
		mainLayer.addChild(bmp);
		
		addLayer(mainLayer);
		
		
	}
	
}
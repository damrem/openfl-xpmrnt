package;

import haxe.Json;
import hxlpers.game.Place;
import hxlpers.tiled.TileMapData;
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
class TileSheetPlace extends Place
{

	public function new(fullWidth:Float, fullHeight:Float, ratio:UInt) 
	{
		super(fullWidth, fullHeight, ratio);
		
		var rawTileSheet = Assets.getBitmapData("img/bugtilesbrown.png");
		
		var dt:TileMapData = new TileMapData(Json.parse(Assets.getText("lvl/ring.json")));
		
		var tileMap = new BitmapData(dt.width * dt.tileWidth, dt.height * dt.tileHeight, true, 0);
		
		var srcRect = new Rectangle(0, 0, dt.tileWidth, dt.tileHeight);
		var destPoint = new Point(0, 0);
		
		//var di:UInt = 0;
		
		
		
		var tileset = dt.tileSets[0];
		
		var w:UInt = tileset.imageWidth - tileset.margin * 2;
		var tileWidthPlusSpacing:UInt = tileset.tileWidth + tileset.spacing;
		var tileHeightPlusSpacing:UInt = tileset.tileHeight + tileset.spacing;
		var nbCols:UInt = Std.int((w + tileset.spacing) / tileWidthPlusSpacing);
		var nbSpacing:UInt = nbCols - 1;
		trace("nbCols="+nbCols);
		trace(nbSpacing);
		
		
		
		var layer = dt.layers[0];
		
		
		
		//for (i in 0...layer.data.length)
		
		var i:UInt = 0;
		for (_y in 0...dt.height)
		{
			for (_x in 0...dt.width)
			{
				
				var j = layer.data[i]-1;
				
				var col:UInt = j % cast(nbCols);
				var row:UInt = Std.int(j / nbCols);
				trace(i, j, col, row);
				
				srcRect.x = tileset.margin + col * tileWidthPlusSpacing;
				srcRect.y = tileset.margin + row * tileHeightPlusSpacing;
				
				destPoint.x = _x * dt.tileWidth;
				destPoint.y = _y * dt.tileHeight;
				
				
				tileMap.copyPixels(rawTileSheet, srcRect, destPoint);
				//tileMap.draw(rawTileSheet, new Matrix(1, 0, 0, 1, destRect.x, destRect.y), null, null, srcRect);
				
				i++;
			}
		}
		
		addChild(new Bitmap(tileMap));
		
		//for(i in levelData.
		
		
		//trace(Xml.parse(levelData).);
		
	}
	
}
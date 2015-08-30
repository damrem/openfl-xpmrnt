package hxlpers.tiled;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * ...
 * @author damrem
 */
class TileMapBitmapData extends BitmapData
{

	public function new(level:TileMapDef, tileSetBitmapData:BitmapData) 
	{
		super(level.width * level.tileWidth, level.height * level.tileHeight, true, 0);
		
		var srcRect = new Rectangle(0, 0, level.tileWidth, level.tileHeight);
		var destPoint = new Point(0, 0);
		
		var tileset = level.tileSets[0];
		
		var w:UInt = tileset.imageWidth - tileset.margin * 2;
		var tileWidthPlusSpacing:UInt = tileset.tileWidth + tileset.spacing;
		var tileHeightPlusSpacing:UInt = tileset.tileHeight + tileset.spacing;
		var nbCols:UInt = Std.int((w + tileset.spacing) / tileWidthPlusSpacing);
		var nbSpacing:UInt = nbCols - 1;
		trace("nbCols="+nbCols);
		trace(nbSpacing);
		
		
		
		var layer = level.layers[0];
		
		
		
		
		//	TODO	we loop through x,y: compare perf with running through data: for (i in 0...layer.data.length)...
		var i:UInt = 0;	//	the index in data
		for (_y in 0...level.height)
		{
			for (_x in 0...level.width)
			{
				var j = layer.data[i] - tileset.firstGId;	// the index in the sprite sheet (-1 because tiled indexes tiles from 1 instead of from 0)
				
				srcRect.x = tileset.margin + (j % cast(nbCols)) * tileWidthPlusSpacing;
				srcRect.y = tileset.margin + Std.int(j / nbCols) * tileHeightPlusSpacing;
				
				destPoint.x = _x * level.tileWidth;
				destPoint.y = _y * level.tileHeight;
				
				copyPixels(tileSetBitmapData, srcRect, destPoint);
				i++;
			}
		}
	}
	
}
package tiledbox2d;
import box2D.dynamics.B2World;
import hxlpers.tiled.TileMapDef;

/**
 * ...
 * @author damrem
 */
class PhyTileMap
{
	public function new(level:TileMapDef, bodyCreator:BodyCreator) 
	{
		var tileset = level.tileSets[0];
		
		var layer = level.layers[0];
		
		var i:UInt = 0;	//	the index in data
		for (_y in 0...level.height)
		{
			for (_x in 0...level.width)
			{
				var j:Int = layer.data[i] - tileset.firstGId;	// the index in the sprite sheet (-1 because tiled indexes tiles from 1 instead of from 0)
				
				trace("j=" + j);
				/*
				srcRect.x = tileset.margin + (j % cast(nbCols)) * tileWidthPlusSpacing;
				srcRect.y = tileset.margin + Std.int(j / nbCols) * tileHeightPlusSpacing;
					*/
				
				if (j >= 0)
				{
					var x = _x * level.tileWidth;
					var y = _y * level.tileHeight;
				
					bodyCreator.createBoxBody(x, y, tileset.tileWidth, tileset.tileHeight);
				}
				/*
				copyPixels(tileSetBitmapData, srcRect, destPoint);
				*/
				i++;
			}
		}
	}
	
}
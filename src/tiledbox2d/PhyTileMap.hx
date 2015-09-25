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
		
		var shapeMap = new Map<UInt, UInt>();
		shapeMap.set(0, 0);
		
		
		var i:UInt = 0;	//	the index in data
		for (_y in 0...level.height)
		{
			for (_x in 0...level.width)
			{
				var j:Int = layer.data[i] - tileset.firstGId;	// the index in the sprite sheet (-1 because tiled indexes tiles from 1 instead of from 0)
				
				if (j >= 0)
				{
					if (tileset.tileProperties[j] != null && tileset.tileProperties[j].phyBits != null)
					{
					
						var x = (_x + 0.5) * level.tileWidth;
						var y = (_y + 0.5) * level.tileHeight;
						bodyCreator.createBlockBody(x, y, tileset.tileProperties[j].phyBits, tileset.tileHeight);
					}
				}
				i++;
			}
		}
	}
	
}
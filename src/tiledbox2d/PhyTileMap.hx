package tiledbox2d;
import box2D.dynamics.B2World;
import hxlpers.tiled.TileMapDef;
import hxlpers.tiled.TileSetDef;

/**
 * ...
 * @author damrem
 */
class PhyTileMap
{
	public function new(tileMapDef:TileMapDef, phyTileCreator:PhyTileCreator) 
	{
		var tileSet = tileMapDef.tileSets[0];
		
		var layer = tileMapDef.layers[0];
		
		var i:UInt = 0;	//	the index in data
		for (_y in 0...tileMapDef.height)
		{
			for (_x in 0...tileMapDef.width)
			{
				var j:Int = layer.data[i] - tileSet.firstGId;	// the index in the sprite sheet (-1 because tiled indexes tiles from 1 instead of from 0)
				
				if (j >= 0)
				{
					if (tileSet.tileProperties[j] != null && tileSet.tileProperties[j].phyBits != null)
					{
					
						var x = (_x + 0.5) * tileMapDef.tileWidth;
						var y = (_y + 0.5) * tileMapDef.tileHeight;
						trace(tileSet.tileProperties[j]);
						phyTileCreator.createBody(x, y, tileSet.tileProperties[j].phyBits, tileSet.tileHeight);
					}
				}
				i++;
			}
		}
	}
	
}
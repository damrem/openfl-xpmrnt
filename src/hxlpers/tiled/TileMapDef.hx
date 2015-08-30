package hxlpers.tiled;

/**
 * ...
 * @author damrem
 */
class TileMapDef
{
	public var width:UInt;
	public var height:UInt;
	public var layers:Array<TileMapLayer>;
	public var orientation:TileMapOrientation;
	public var properties:Dynamic;
	public var tileHeight:UInt;
	public var tileWidth:UInt;
	public var version:UInt;
	public var tileSets:Array<TileSet>;
	
	public function new(json:Dynamic) 
	{
		width = json.width;
		height = json.height;
		
		layers = [];
		tileSets = [];
		
		for (layer in cast(json.layers, Array<Dynamic>))
		{
			layers.push(new TileMapLayer(layer));
		}
		
		for (tileSet in cast(json.tilesets, Array<Dynamic>))
		{
			tileSets.push(new TileSet(tileSet));
		}
		
		var orientationMapping = new Map<String, TileMapOrientation>();
		orientationMapping.set("orthogonal", TileMapOrientation.Orthogonal);
		orientationMapping.set("isometric", TileMapOrientation.Isometric);
		orientationMapping.set("staggered", TileMapOrientation.Staggered);
		orientation = orientationMapping.get(json.orientation);
		
		properties = json.properties;
		tileWidth = json.tilewidth;
		tileHeight = json.tileheight;
		
		version = json.version;
	}
	
}


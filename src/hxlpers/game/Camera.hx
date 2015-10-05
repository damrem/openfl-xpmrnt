package hxlpers.game;
import hxlpers.game.Room;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;

using hxlpers.display.BitmapDataSF;
using hxlpers.display.DisplayObjectSF;

/**
 * ...
 * @author damrem
 */
class Camera
{

	public var data:BitmapData;
	public var zone:Rectangle;
	public var initialZone:Rectangle;
	
	var room:Room;
	public var zoomLevel:Float=1;	
	var followed:Dynamic;
	
	public function new(room:Room, ?zone:Rectangle) 
	{
		this.room = room;

		if (zone == null)
		{
			zone = Conf.VIEW_PORT;
		}
		
		this.zone = initialZone = zone;
		
		data = new BitmapData(Math.ceil(zone.width / Conf.PIXEL_SIZE), Math.ceil(zone.height / Conf.PIXEL_SIZE));
	}
	
	function setRoom(room:Room)
	{
		this.room = room;
	}
	
	public function follow(object:Dynamic)
	{
		followed = object;
	}
	
	public function update()
	{
		if (followed != null)
		{
			//FIXME half dimension offset
			zone.x = followed.x;
			zone.y = followed.y;
		}
		
		
	}
	
	public function shoot(layerList:LayerList) 
	{
		data.clear(0xff000000);
		for (layer in layerList.getLayers())
		{
			if (layer.isVisible)
			{
				data.draw(layer);
				//screen.draw(layer/*, new Matrix(zoomLevel, 0, 0, zoomLevel, screen.width/2-pos.x, 0)*/);//FIXME the last 0 should be -rect.y, but it shifts incoherently
			}
		}
	}
	
}


package hxlpers.game;
import hxlpers.game.Room;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * ...
 * @author damrem
 */
class Camera
{

	var room:Room;
	var zoomLevel:Float;
	public var zone:Rectangle;
	var screen:BitmapData;
	var followed:Dynamic;
	public var focusObject:Dynamic;
	
	public function new(zone:Rectangle) 
	{
		this.zone = zone;
		//screen=new BitmapData
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
			zone.x = followed.x;
			zone.y = followed.y;
		}
	}
	
	
}


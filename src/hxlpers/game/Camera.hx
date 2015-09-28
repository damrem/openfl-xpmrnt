package hxlpers.game;
import hxlpers.game.Room;
import openfl.display.BitmapData;
import openfl.geom.Point;

/**
 * ...
 * @author damrem
 */
class Camera
{

	var room:Room;
	var zoomLevel:Float;
	public var focusCenter:Point;
	var screen:BitmapData;
	var followed:Dynamic;
	public var focusObject:Dynamic;
	
	public function new() 
	{
		focusCenter = new Point();
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
		focusCenter.x = followed.x;
		focusCenter.y = followed.y;
	}
	
}


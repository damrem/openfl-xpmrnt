package hxlpers.game;
import hxlpers.game.Room;
import hxlpers.geom.Dim;
import hxlpers.geom.Pos;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.geom.Matrix;
import openfl.geom.Point;
import openfl.geom.Rectangle;

using hxlpers.display.BitmapDataSF;

/**
 * ...
 * @author damrem
 */
class Camera
{

	public var screen:BitmapData;
	public var rect(get, null):Rectangle;
	public var focusObject:Dynamic;

	var pos:Pos;
	var dim:Dim;
	
	var room:Room;
	var zoomLevel:Float;	
	var followed:Dynamic;
	
	public function new(pos:Pos, dim:Dim) 
	{
		trace(dim);
		this.dim = dim;
		this.pos = pos;
		
		screen = new BitmapData(Math.ceil(dim.w), Math.ceil(dim.h));
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
			pos.x = followed.x;
			pos.y = followed.y;
		}
	}
	
	public function render(room:Room) 
	{
		screen.clear(0xff000000);
		screen.draw(room, new Matrix(1, 0, 0, 1, -rect.x, 0));//FIXME the last 0 should be -rect.y, but it shifts incoherently
	}
	
	function get_rect():Rectangle 
	{
		return new Rectangle(pos.x - dim.w / 2, pos.y - dim.h / 2, dim.w, dim.h);
	}
	
	
}


package hxlpers.game;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.geom.Matrix;
using hxlpers.display.BitmapDataSF;
/**
 * ...
 * @author damrem
 */
class Room extends Sprite
{
	var w:Float;
	var h:Float;
	var ratio:UInt;
	
	public var rendering(get, null):BitmapData;
	
	function get_camera():Camera 
	{
		return _camera;
	}
	
	function set_camera(value:Camera):Camera 
	{
		return _camera = value;
	}
	var _rendering:BitmapData;
	var camera(get, set):Camera;
	var _camera:Camera;
	
	public function new(fullWidth:Float, fullHeight:Float, ratio:UInt)
	{
		super();
		w = fullWidth / ratio;
		h = fullHeight / ratio;
		this.ratio = ratio;
		_rendering = new BitmapData(Math.ceil(w), Math.ceil(h));
		_camera = new Camera();
	}
	
	public function update()
	{
		trace("update");
		_camera.update();
	}
	
	public function play()
	{
		
	}
	
	public function pause()
	{
		
	}
	
	public function render()
	{
		_rendering.clear(0xff000000);
		_rendering.draw(this, new Matrix(1, 0, 0, 1, -_camera.focusCenter.x, -_camera.focusCenter.y));
	}
	
	function get_rendering():BitmapData 
	{
		return _rendering;
	}
	
}
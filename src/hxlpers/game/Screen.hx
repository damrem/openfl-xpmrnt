package hxlpers.game;
import openfl.display.Bitmap;
import openfl.geom.Rectangle;

/**
 * ...
 * @author damrem
 */
class Screen extends Bitmap
{
	var camera:Camera;
	var zone:Rectangle;

	public function new(camera:Camera, zone:Rectangle) 
	{
		super();
		this.zone = zone;
		x = zone.x;
		y = zone.y;
		if (camera != null)
		{
			setCamera(camera);
		}
	}
	
	public function setCamera(camera:Camera)
	{
		this.bitmapData = camera.data;
		width = zone.width;
		height = zone.height;
	}
	
}
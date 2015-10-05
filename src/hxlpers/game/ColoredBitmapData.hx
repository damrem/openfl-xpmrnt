package hxlpers.game;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;

/**
 * ...
 * @author damrem
 */
class ColoredBitmapData extends BitmapData
{
	public var fillColor:UInt;

	public function new(transparent:Bool=true, fillColor:UInt=0xFFFFFFFF, ?zone:Rectangle) 
	{
		if (zone == null)
		{
			zone = Conf.VIEW_PORT;
		}
		
		super(Math.ceil(zone.width), Math.ceil(zone.height), transparent, fillColor);
		this.fillColor = fillColor;
	}
	
	public function fill()
	{
		fillRect(rect, fillColor);
	}
	
}
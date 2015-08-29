package hxlpers.display;
import hxlpers.colors.RGBColor;
import openfl.display.Graphics;

/**
 * ...
 * @author damrem
 */
class GraphicsSF
{

	static public function box(user:Graphics, w:Float, h:Float, fillColor:UInt=0xffffff, borderThickness:Float=0, borderColor:UInt=0x000000, centered:Bool=false):Graphics 
	{
		if (borderThickness > 0)
		{
			user.lineStyle(borderThickness, borderColor);
		}
		user.beginFill(fillColor);
		user.drawRect(centered? -w / 2:0, centered? -h / 2:0, w, h);
		user.endFill();
		return user;
	}
	
}
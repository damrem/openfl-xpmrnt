package hxlpers.display;
import openfl.display.Shape;
using hxlpers.display.GraphicsSF;
/**
 * ...
 * @author damrem
 */
class ShapeSF
{

	static public function box(user:Shape, w:Float, h:Float, fillColor:UInt=0xffffff, borderThickness:Float=0, borderColor:UInt=0x000000, centered:Bool=false):Shape
	{
		user.graphics.box(w, h, fillColor, borderThickness, borderColor, centered);
		return user;
	}
	
	
	
}
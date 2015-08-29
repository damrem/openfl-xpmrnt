package hxlpers.display;
import openfl.display.DisplayObject;
using hxlpers.display.GraphicsSF;

/**
 * ...
 * @author damrem
 */
class DisplayObjectSF
{
	static public function scale(user:DisplayObject, factor:Float=1.0):Float
	{
		return user.scaleX = user.scaleY = factor;
	}
}
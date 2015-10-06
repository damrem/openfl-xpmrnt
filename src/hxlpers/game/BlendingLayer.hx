package hxlpers.game;

import openfl.display.IBitmapDrawable;
import openfl.geom.Rectangle;

/**
 * ...
 * @author damrem
 */
class BlendingLayer extends Layer
{

	public function new(?zone:Rectangle) 
	{
		super(false, true, zone);	
	}
	
	override public function getDrawable():IBitmapDrawable
	{
		return getBitmap();
	}
	
}
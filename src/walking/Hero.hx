package walking;
import hxlpers.colors.Colors;
import hxlpers.geom.V2d;
import openfl.Assets;
import openfl.display.Shape;
import openfl.display.Tilesheet;
import openfl.geom.Rectangle;
using hxlpers.display.DisplayObjectSF;
/**
 * ...
 * @author damrem
 */
class Hero extends Shape
{
	public var isWalking:Bool;
	var ts:Tilesheet;
	
	var nbSteps:UInt=0;
	public function new() 
	{
		super();
		
		var tileRect0:Rectangle = new Rectangle(0, 0, 6, 6);
		var tileRect1:Rectangle = new Rectangle(6, 0, 6, 6);
		
		ts = new Tilesheet(Assets.getBitmapData("img/tiny-alien.png"));
		ts.addTileRect(tileRect0);
		ts.addTileRect(tileRect1);
		
		update();
		
		color(Colors.WHITE);
	}
	
	public function update() 
	{
		
		if (isWalking)
		{
			//trace("walk");
			
			graphics.clear();
			ts.drawTiles(graphics, [0, 0, nbSteps % 2]);
			nbSteps++;
		}
		else
		{
			graphics.clear();
			ts.drawTiles(graphics, [0, 0, 0]);
		}
	}
	
}
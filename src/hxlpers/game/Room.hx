package hxlpers.game;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;
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
	
	var layerList:LayerList;
	
	public var camera:Camera;
	
	
	public function new(fullWidth:Float, fullHeight:Float, ratio:UInt)
	{
		super();
		w = fullWidth / ratio;
		h = fullHeight / ratio;
		this.ratio = ratio;
		
		layerList = new LayerList();
		camera = new Camera( { x:w / 2, y:w / 2 }, { w:w, h:h } );
	}
	
	public function update()
	{
		//trace("update");
		camera.update();
		layerList.update();
	}
	
	public function play()
	{
		
	}
	
	public function pause()
	{
		
	}
	
	public function render()
	{
		camera.render(this);
	}
	
}
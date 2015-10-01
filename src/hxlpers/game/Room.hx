package hxlpers.game;
import hxlpers.game.Layer;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;
using hxlpers.display.BitmapDataSF;
using hxlpers.display.DisplayObjectSF;
/**
 * ...
 * @author damrem
 */
class Room extends Sprite
{
	var w:Float;
	var h:Float;
	var ratio:UInt;
	
	var interactiveLayer:Sprite;
	var layerList:LayerList;
	
	public var camera:Camera;
	
	
	public function new(fullWidth:Float, fullHeight:Float, ratio:UInt)
	{
		super();
		w = fullWidth / ratio;
		h = fullHeight / ratio;
		this.ratio = ratio;
		
		layerList = new LayerList();
		camera = new Camera(this, { x:w / 2, y:w / 2 }, { w:w, h:h } );
		
		interactiveLayer = new Sprite();
		interactiveLayer.alpha = 0;
		interactiveLayer.scale(ratio);
	}
	
	function addLayer(layer:Layer, mouseInteractive:Bool=false) 
	{
		layerList.addLayer(layer);
		if (mouseInteractive) {
			interactiveLayer.addChild(layer);
			addChild(interactiveLayer);
		}
	}
	
	public function update()
	{
		//trace("update");
		layerList.update();
		camera.update();
	}
	
	public function play()
	{
		trace("play");
		addChild(interactiveLayer);
		trace(this.stage);
	}
	
	public function pause()
	{
		trace("pause");
		removeChild(interactiveLayer);
	}
	
	public function render()
	{
		camera.render(layerList);
	}
	
}
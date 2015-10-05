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
	
	var interactiveLayerHolder:Sprite;
	var screenHolder:Sprite;

	var layerList:LayerList;
	
	public var defaultCamera:Camera;
	public var defaultScreen:Screen;
	
	var screens:Array<Screen>;
	
	
	public function new(fullWidth:Float, fullHeight:Float, ratio:UInt)
	{
		super();
		w = fullWidth / ratio;
		h = fullHeight / ratio;
		this.ratio = ratio;
		
		screens = [];
		
		layerList = new LayerList();
		defaultCamera = new Camera(this, { x:w / 2, y:w / 2 }, { w:w, h:h } );
		
		screenHolder = new Sprite();
		screenHolder.scale(ratio);
		addChild(screenHolder);
		
		defaultScreen = addScreen(defaultCamera, Conf.VIEW_PORT);
		
		interactiveLayerHolder = new Sprite();
		interactiveLayerHolder.alpha = 0;
		interactiveLayerHolder.scale(ratio);
	}
	
	function addScreen(camera:Camera, rect:Rectangle):Screen
	{
		var screen = new Screen(camera, rect);
		screenHolder.addChild(screen);
		screens.push(screen);
		return screen;
	}
	
	function addLayer(layer:Layer):Layer 
	{
		trace("addLayer", layer);
		layerList.addLayer(layer);
		
		if (layer.isVisible)
		{
			screenHolder.addChild(layer.getBitmap());
		}
		
		if (layer.isMouseInteractive) {
			interactiveLayerHolder.addChild(layer);
			addChild(interactiveLayerHolder);
		}
		return layer;
	}
	
	public function update()
	{
		layerList.update();
		defaultCamera.update();
	}
	
	public function play()
	{
		trace("play");
		addChild(interactiveLayerHolder);
		trace(this.stage);
	}
	
	public function pause()
	{
		trace("pause");
		removeChild(interactiveLayerHolder);
	}
	
	public function render()
	{
		defaultCamera.render(layerList);
	}
	
}
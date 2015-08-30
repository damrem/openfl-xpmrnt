package hxlpers.game;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.Event;
using hxlpers.display.DisplayObjectSF;
using hxlpers.display.BitmapDataSF;

/**
 * ...
 * @author damrem
 */
class Game extends Sprite
{
	var places:Map<String, Place>;
	var buffer:BitmapData;
	var currentPlace:Place;
	var interactiveLayer:Sprite;
	var isPlaying:Bool;
	var ratio:Float;
	
	public function new(w:UInt, h:UInt, ratio:UInt) 
	{
		super();
		this.ratio = ratio;
		
		places = new Map<String, Place>();
		buffer = new BitmapData(Math.ceil(w / ratio), Math.ceil(h / ratio), false, 0xff0000);
		
		var renderLayer = new Bitmap(buffer);
		//trace(renderLayer.width);
		renderLayer.scale(ratio);
		//trace(renderLayer.width);
		addChild(renderLayer);
		
		interactiveLayer = new Sprite();
		interactiveLayer.alpha = 0;
		interactiveLayer.scale(ratio);
		
		addEventListener(Event.ADDED_TO_STAGE, onStage);
		
		trace(mouseChildren);
	}
	
	private function onStage(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onStage);
		trace("onStage");
	}
	
	public function play()
	{
		trace("play");
		isPlaying = true;
		addChild(interactiveLayer);
		addEventListener(Event.ENTER_FRAME, update);
		currentPlace.play();
	}
	
	public function pause()
	{
		trace("pause");
		isPlaying = false;
		currentPlace.pause();
		removeChild(interactiveLayer);
		removeEventListener(Event.ENTER_FRAME, update);
	}
	
	public function update(evt:Event=null)
	{
		//trace("update");
		currentPlace.update();
		render();
	}
	
	
	
	public function render()
	{
		buffer.clear();
		buffer.draw(currentPlace);
	}
	
	public function addPlace(id:String, place:Place) 
	{
		trace("addPlace", id, place);
		//place.scale(1 / ratio);
		places.set(id, place);
		setCurrentPlace(id);
	}
	
	public function setCurrentPlace(id:String)
	{
		trace("setCurrentPlace", id);
		var firstPlace:Bool = true;
		if (currentPlace != null)
		{
			firstPlace = false;
			currentPlace.pause();
		}
		
		currentPlace = places.get(id);
		interactiveLayer.removeChildren();
		
		if (isPlaying || firstPlace)
		{
			play();
		}
		
		interactiveLayer.addChild(currentPlace);
		trace(interactiveLayer.width);
		trace(interactiveLayer.scaleX);
	}
	
}
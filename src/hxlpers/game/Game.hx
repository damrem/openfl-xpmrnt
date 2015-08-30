package hxlpers.game;
import hxlpers.effects.ScreenPixelEffect;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.BlendMode;
import openfl.display.Sprite;
import openfl.events.Event;
using hxlpers.display.DisplayObjectSF;
using hxlpers.display.BitmapDataSF;
using hxlpers.effects.BitmapDataPixelEffectSF;
/**
 * ...
 * @author damrem
 */
class Game extends Sprite
{
	var places:Map<String, Place>;
	//var rendering:BitmapData;
	var currentPlace:Place;
	var interactiveLayer:Sprite;
	var isPlaying:Bool;
	var ratio:Float;
	var postRendering:openfl.display.BitmapData;
	var renderingContainer:openfl.display.Sprite;
	var fullWidth:UInt;
	var fullHeight:UInt;
	var pixelEffect:ScreenPixelEffect;
	var renderingLayer:openfl.display.Bitmap;
	
	public function new(fullWidth:UInt, fullHeight:UInt, ratio:UInt) 
	{
		super();
		this.fullHeight = fullHeight;
		this.fullWidth = fullWidth;
		this.ratio = ratio;
		
		
		
		places = new Map<String, Place>();
		//rendering = new BitmapData(Math.ceil(fullWidth / ratio), Math.ceil(fullHeight / ratio), false, 0xff000000);
		
		
		renderingLayer = new Bitmap();
		//trace(renderLayer.width);
		renderingLayer.scale(ratio);
		//trace(renderLayer.width);
		
		renderingContainer = new Sprite();
		renderingContainer.addChild(renderingLayer);
		
		postRendering = new BitmapData(fullWidth, fullHeight, false, 0xff000000);
		var postRenderingLayer=new Bitmap(postRendering);
		addChild(postRenderingLayer);
		
		interactiveLayer = new Sprite();
		interactiveLayer.alpha = 0;
		interactiveLayer.scale(ratio);
		
		pixelEffect = new ScreenPixelEffect(fullWidth, fullHeight, Assets.getBitmapData("img/px3.png"));
		
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
		
		currentPlace.render();
		//rendering.draw(currentPlace);
		postRendering.draw(renderingContainer);
		//postRendering.draw(pixelEffect, null, null, BlendMode.LIGHTEN);
		//postRendering.pixelEffect(3);
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
		renderingLayer.bitmapData = currentPlace.rendering;
		trace(interactiveLayer.width);
		trace(interactiveLayer.scaleX);
	}
	
}
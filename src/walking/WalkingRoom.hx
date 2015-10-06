package walking;

import hxlpers.colors.Colors;
import hxlpers.colors.RndColor;
import hxlpers.effects.ScreenWhiteNoiseEffect;
import hxlpers.game.Layer;
import hxlpers.game.Room;
import openfl.display.Shape;
import openfl.events.KeyboardEvent;
import openfl.geom.Rectangle;
import openfl.Lib;
using hxlpers.display.SpriteSF;
using hxlpers.display.ShapeSF;
using hxlpers.display.DisplayObjectSF;
using hxlpers.IntSF;
/**
 * ...
 * @author damrem
 */
class WalkingRoom extends Room
{
	var bgLayer:Layer;
	var isWalking:Bool;
	
	var hero:Hero;
	var sky:ScreenWhiteNoiseEffect;

	public function new() 
	{
		super();
		
		bgLayer = new Layer();
		
		//bgLayer.rect(w*2, h, RndColor.rgb());
		addLayer(bgLayer);
		
		var skyLayer = addLayer(new Layer());
		sky = new ScreenWhiteNoiseEffect(3, 0.1, 3, zone);
		sky.color(Colors.WHITE);
		sky.alpha = 0.25;
		skyLayer.addChild(sky);
		
		
		
		var groundLayer = addLayer(new Layer());
		var ground = new Shape();
		ground.rect(zone.width, zone.height / 3, Colors.WHITE);
		ground.y = zone.height - ground.height;
		groundLayer.addChild(ground);
		
		
		var heroLayer = addLayer(new Layer());
		hero = new Hero();
		
		hero.x = 10;
		hero.scale(Conf.PIXEL_SIZE);
		hero.y = ground.y - hero.height;
		heroLayer.addChild(hero);
		
		defaultCamera.follow(hero);
		
		
		var i:UInt = 123456;
		trace(i.toFixedLengthString(5));
		
	}
	
	override public function play()
	{
		trace("play");
		super.play();
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}
	
	override public function pause()
	{
		super.play();
		Lib.current.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		Lib.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}
	
	private function onKeyDown(e:KeyboardEvent):Void 
	{
		//trace("onKeyDown", e);
		hero.isWalking = true;
	}
	
	private function onKeyUp(e:KeyboardEvent):Void
	{
		//trace("onKeyUp", e);
		hero.isWalking = false;
	}
	
	override public function update()
	{
		if (hero.isWalking)
		{
			hero.x += 2;
		}
		hero.update();
		
		if (hero.x > zone.width / 2)
		{
			
		}
		
		
		if (hero.x > zone.width)
		{
			bgLayer.rect(zone.width*2, zone.height, RndColor.rgb());
			hero.x = -hero.width;
			sky.next();
		}
		
		super.update();
	}
	
}
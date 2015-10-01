package walking;

import hxlpers.colors.Colors;
import hxlpers.colors.RndColor;
import hxlpers.effects.ScreenWhiteNoiseEffect;
import hxlpers.game.Layer;
import hxlpers.game.Room;
import openfl.Assets;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.display.Tilesheet;
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

	public function new(fullWidth:Float, fullHeight:Float, ratio:UInt) 
	{
		super(fullWidth, fullHeight, ratio);
		
		bgLayer = new Layer();
		trace(w, h);
		bgLayer.rect(w*2, h, RndColor.rgb());
		addLayer(bgLayer);
		
		var skyLayer = new Layer();
		sky = new ScreenWhiteNoiseEffect(cast(w*2), cast(h), 3, 0.1);
		sky.color(Colors.WHITE);
		sky.alpha = 0.25;
		skyLayer.addChild(sky);
		addLayer(skyLayer);
		
		
		var groundLayer = new Layer();
		var ground = new Shape();
		ground.rect(w * 2, h / 3, Colors.WHITE);
		ground.y = this.h - ground.height;
		groundLayer.addChild(ground);
		addLayer(groundLayer);
		
		var heroLayer = new Layer();
		hero = new Hero();
		
		hero.x = 10;
		hero.y = ground.y - hero.height;
		heroLayer.addChild(hero);
		addLayer(heroLayer);
		
		camera.follow(hero);
		
		
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
		
		if (hero.x > w / 2)
		{
			
		}
		
		
		if (hero.x > w)
		{
			bgLayer.rect(w*2, h, RndColor.rgb());
			hero.x = -hero.width;
			sky.next();
		}
		
		super.update();
	}
	
}
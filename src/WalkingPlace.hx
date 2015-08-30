package;

import hxlpers.colors.Colors;
import hxlpers.colors.RndColor;
import hxlpers.effects.ScreenWhiteNoiseEffect;
import hxlpers.game.Place;
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
/**
 * ...
 * @author damrem
 */
class WalkingPlace extends Place
{
	var bg:Sprite;
	var isWalking:Bool;
	var ts:Tilesheet;
	var hero:Shape;
	var nbSteps:UInt=0;

	public function new(fullWidth:Float, fullHeight:Float, ratio:UInt) 
	{
		super(fullWidth, fullHeight, ratio);
		
		bg = new Sprite();
		trace(w, h);
		bg.box(w, h, RndColor.rgb());
		addChild(bg);
		
		var sky = new ScreenWhiteNoiseEffect(cast(w), cast(h), 1, 0.1);
		sky.color(Colors.WHITE);
		sky.alpha = 0.25;
		addChild(sky);
		
		var ground = new Shape();
		addChild(ground.box(w, h / 3, Colors.WHITE));
		ground.y = this.h - ground.height;
		
		
		var tileRect0:Rectangle = new Rectangle(0, 0, 6, 6);
		var tileRect1:Rectangle = new Rectangle(6, 0, 6, 6);
		ts = new Tilesheet(Assets.getBitmapData("img/tiny-alien.png"));
		ts.addTileRect(tileRect0);
		ts.addTileRect(tileRect1);
		
		hero = new Shape();
		ts.drawTiles(hero.graphics, [0, 0, 0]);
		hero.color(Colors.WHITE);
		hero.x = 10;
		hero.y = ground.y - hero.height;
		addChild(hero);
		
		
		
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
		trace("onKeyDown", e);
		isWalking = true;
	}
	
	private function onKeyUp(e:KeyboardEvent):Void
	{
		trace("onKeyUp", e);
		isWalking = false;
	}
	
	override public function update()
	{
		if (isWalking)
		{
			trace("walk");
			hero.x += 2;
			hero.graphics.clear();
			ts.drawTiles(hero.graphics, [0, 0, nbSteps % 2]);
			nbSteps++;
		}
		else
		{
			hero.graphics.clear();
			ts.drawTiles(hero.graphics, [0, 0, 0]);
		}
		if (hero.x > w)
		{
			bg.color(RndColor.rgb());
			hero.x = -hero.width;
		}
	}
	
}
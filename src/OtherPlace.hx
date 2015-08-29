package;

import hxlpers.game.Place;
import hxlpers.Rnd;
import hxlpers.shapes.BoxShape;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;

/**
 * ...
 * @author damrem
 */
class OtherPlace extends Place
{

	var hero:Shape;
	var bg:Sprite;
	
	public function new(w:Float, h:Float) 
	{
		super();
		bg = new Sprite();
		bg.graphics.beginFill(0x00ff00);
		bg.graphics.drawRect(0, 0, w, h);
		bg.graphics.endFill();
		
		hero = new BoxShape(10, 10, 0xff0000, 0, 0, true);
		
		
		addChild(bg);
		addChild(hero);
		
		addEventListener(Event.ADDED_TO_STAGE, onStage);
	}
	
	private function onStage(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onStage);
		trace("onStage");
	}
	
	override public function play()
	{
		super.play();
		trace("play");
		trace(parent);
		bg.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
	}
	
	override public function pause()
	{
		super.pause();
		trace("pause");
		bg.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
	}
	
	private function onMouseMove(e:MouseEvent):Void 
	{
		trace("onMouseMove", e);
		hero.x = Math.round(e.localX);
		hero.y = Math.round(e.localY);
	}
	
	override public function update()
	{
		super.update();
		/*if (Rnd.chance())
		{
			
		}*/
	}
	
}
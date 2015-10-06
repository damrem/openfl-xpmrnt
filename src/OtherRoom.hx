package;

import hxlpers.colors.ColorComponent;
import hxlpers.colors.Colors;
import hxlpers.colors.RndColor;
import hxlpers.game.Layer;
import hxlpers.game.Room;
import openfl.display.Shape;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Point;
using hxlpers.display.SpriteSF;
using hxlpers.display.ShapeSF;

/**
 * ...
 * @author damrem
 */
class OtherRoom extends Room
{
	
	var hero:Shape;
	var ppc:Point;
	var fg:Layer;
	
	public function new() 
	{
		super();
		
		var bg = addLayer(new Layer());
		bg.rectangle(zone, Colors.WHITE);
		
		var heroLayer = addLayer(new Layer());
		hero = new Shape();
		hero.rect(10, 10, Colors.RED, 0, 0, true);
		addEventListener(MouseEvent.CLICK, onClick);
		heroLayer.addChild(hero);
		
		
		fg = addLayer(new Layer(true, false));
		fg.rectangle(Conf.VIEW_PORT, 0x00000000);
		
		addEventListener(Event.ADDED_TO_STAGE, onStage);
	}
	
	private function onClick(e:MouseEvent):Void 
	{
		trace("click");
		//ppc.x +=w/8;
		//ppc.y += h / 8;
		trace(ppc);
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
		fg.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
	}
	
	override public function pause()
	{
		super.pause();
		trace("pause");
		fg.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
	}
	
	private function onMouseMove(e:MouseEvent):Void 
	{
		//trace(e.localX, e.localY, e.stageX, e.stageY);
		hero.x = Math.round(e.stageX);
		hero.y = Math.round(e.stageY);
		
		
	}
	
	override public function update()
	{
		super.update();
		//hero.rotationX++;
		/*if (Rnd.chance())
		{
			
		}*/
		//hero.transform.perspectiveProjection.projectionCenter.x = hero.x;
		//hero.transform.perspectiveProjection.projectionCenter.y = hero.y;
	}
	
}
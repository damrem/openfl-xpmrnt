package;

import hxlpers.colors.RndColor;
import hxlpers.game.ColoredBitmapData;
import hxlpers.game.Layer;
import hxlpers.game.Room;
import hxlpers.Rnd;
import hxlpers.shapes.BoxShape;
import openfl.Assets;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.PerspectiveProjection;
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
	
	public function new(fullWidth:Float, fullHeight:Float, ratio:UInt) 
	{
		super(fullWidth, fullHeight, ratio);
		
		var bg = addLayer(new Layer(new ColoredBitmapData(w, h, true, RndColor.argb())));
		
		var heroLayer = addLayer(new Layer(new ColoredBitmapData(w, h, true, 0)));
		hero = new Shape();
		hero.rect(10, 10, RndColor.gray(), 0, 0, true);
		addEventListener(MouseEvent.CLICK, onClick);
		heroLayer.addChild(hero);
		
		fg = addLayer(new Layer(new ColoredBitmapData(w, h, true), true, false));
		fg.rect(w, h);
		
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
		hero.x = Math.round(e.stageX/ratio);
		hero.y = Math.round(e.stageY/ratio);
		
		
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
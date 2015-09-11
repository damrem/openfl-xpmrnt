package entities;

import ash.core.Engine;
import ash.core.Entity;
import ash.tick.FrameTickProvider;
import hxlpers.colors.RndColor;
import hxlpers.game.Place;
import hxlpers.Rnd;
import hxlpers.shapes.BoxShape;
import hxlpers.shapes.DiskShape;
import hxlpers.shapes.ShortcutShape;
import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class EntityPlace extends Place
{
	var tickProvider:FrameTickProvider;
	var engine:Engine;
	

	public function new(fullWidth:Float, fullHeight:Float, ratio:UInt) 
	{
		super(fullWidth, fullHeight, ratio);
		
		tickProvider = new FrameTickProvider(this);
		
		engine = new Engine();
		
		engine.addSystem(new RandomMoveSystem(), 9);
		engine.addSystem(new RenderSystem(this), 10);
		
		addEntities();
		
		start();
	}
	
	public function start()
	{
		tickProvider.add( engine.update );
		tickProvider.start();
	}
	
	function addEntities(nbEntities:UInt=50)
	{
		//entities = new Array<Sprite>();
		
		for (i in 0...nbEntities)
		{
			var entity = new Entity();
			
			var size = Math.random() * 25;
			var color = RndColor.rgb(0.25, 0.5);
			var shape:ShortcutShape;
			var sprite = new Sprite();
			
			if (Rnd.chance())
			{
				shape = new DiskShape(size, color);
			}
			else
			{
				shape = new BoxShape(size, size, color);
				shape.rotation = Math.random() * 360;
			}
			sprite.addChild(shape);
			sprite.x = Rnd.float(w);
			sprite.y = Rnd.float(h);
			//sprite.buttonMode = true;
			//sprite.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			//maskedLayer.addChild(sprite);
			//entities.push(sprite);
			
			entity.add(new RandomMove());
			entity.add(new Visual(sprite));
			engine.addEntity(entity);
		}
		
		//return maskedLayer;
	}
	
}
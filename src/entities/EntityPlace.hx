package entities;

import ash.core.Engine;
import ash.core.Entity;
import ash.tick.FrameTickProvider;
import box2D.collision.shapes.B2CircleShape;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2BodyType;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;
import entities.physics.Phy;
import entities.physics.PhySystem;
import entities.randommove.RandomMove;
import entities.randommove.RandomMoveSystem;
import entities.rendering.EntitySprite;
import entities.rendering.RenderSystem;
import entities.rendering.SpriteComponent;
import entities.selection.Selectable;
import entities.selection.SelectionSystem;
import hxlpers.colors.RndColor;
import hxlpers.game.Place;
import hxlpers.Rnd;
import hxlpers.shapes.BoxShape;
import hxlpers.shapes.DiskShape;
import hxlpers.shapes.ShortcutShape;
import openfl.display.Sprite;

using hxlpers.display.SpriteSF;

/**
 * ...
 * @author damrem
 */
class EntityPlace extends Place
{
	var tickProvider:FrameTickProvider;
	var engine:Engine;
	var world:box2D.dynamics.B2World;
	var phySystem:PhySystem;
	

	public function new(fullWidth:Float, fullHeight:Float, ratio:UInt) 
	{
		super(fullWidth, fullHeight, ratio);
		
		tickProvider = new FrameTickProvider(this);
		
		engine = new Engine();
		
		var phyDebugSprite = new Sprite();
		//phyDebugSprite.rect(100, 100);
		addChild(phyDebugSprite);
		
		
		world = new B2World(PhySystem.GRAVITY, true);

		
		var bodyDef = new B2BodyDef();
		bodyDef.type = B2BodyType.DYNAMIC_BODY;
		bodyDef.position.set(5, 5);
		
		var phyShape = new B2CircleShape(5);
		
		var fixtureDef = new B2FixtureDef();
		fixtureDef.shape = phyShape;
		fixtureDef.density = 1;
		
		var body = world.createBody(bodyDef);
		body.createFixture(fixtureDef);
		
		trace(world.getBodyCount());
		
		
		phySystem = new PhySystem(world, phyDebugSprite);
		engine.addSystem(phySystem, 1);
		engine.addSystem(new RandomMoveSystem(), 5);
		engine.addSystem(new SelectionSystem(), 10);
		engine.addSystem(new RenderSystem(this), 15);
		
		addEntities();
		
		start();
	}
	
	public function start()
	{
		//tickProvider.add( phySystem.update );
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
			var _x = Rnd.float(w);
			var _y = Rnd.float(h);
			
			
			var color = RndColor.rgb(0.25, 0.5);
			var shape:ShortcutShape;
			var sprite = new EntitySprite(entity);
			
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
			
			
			sprite.x = _x;
			sprite.y = _y;
			
			
			var bodyDef = new B2BodyDef();
			bodyDef.type = B2BodyType.DYNAMIC_BODY;
			bodyDef.position.set(_x, _y);
			
			var phyShape = new B2CircleShape(size);
			
			var fixtureDef = new B2FixtureDef();
			fixtureDef.shape = phyShape;
			fixtureDef.density = 1;
			
			entity.add(new Phy(bodyDef, fixtureDef));
			entity.add(new RandomMove());
			//entity.add(new SpriteComponent(sprite));
			entity.add(new Selectable());
			
			engine.addEntity(entity);
		}
		
		//return maskedLayer;
	}
	
}
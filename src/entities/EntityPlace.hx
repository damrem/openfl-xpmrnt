package entities;

import ash.core.Engine;
import ash.core.Entity;
import ash.tick.FrameTickProvider;
import box2D.collision.shapes.B2CircleShape;
import box2D.collision.shapes.B2PolygonShape;
import box2D.common.math.B2Vec2;
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
import entities.rendering.Gfx;
import entities.selection.Selectable;
import entities.selection.SelectionSystem;
import entities.sync.PhyToGfxSyncSystem;
import hxlpers.colors.Colors;
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
	
	public var phyDebugSprite:openfl.display.Sprite;
	

	public function new(fullWidth:Float, fullHeight:Float, ratio:UInt) 
	{
		super(fullWidth, fullHeight, ratio);
		
		tickProvider = new FrameTickProvider(this);
		
		engine = new Engine();
		
		phyDebugSprite = new Sprite();
		//addChild(phyDebugSprite);
		
		
		world = new B2World(PhySystem.GRAVITY, true);

		
		engine.addSystem(new PhySystem(world, phyDebugSprite, cast(1)), 1);
		engine.addSystem(new RandomMoveSystem(), 10);
		engine.addSystem(new PhyToGfxSyncSystem(), 8);
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
	
	function createBallEntity(_x:Float, _y:Float, size:Float, angle:Float, color:UInt):Entity
	{
		trace("ball");
		var radius = size / 2;
		
		var entity = new Entity();
		
		var shape = new DiskShape(radius, color);
		var sprite = new EntitySprite(entity);
		sprite.addChild(shape);
		entity.add(new Gfx(sprite));
		
		var bodyDef = createBodyDef(_x, _y);
		var fixtureDef = createFixtureDef();
		fixtureDef.shape = new B2CircleShape(radius);
		entity.add(new Phy(bodyDef, fixtureDef));
		
		return entity;
	}
	
	function createBoxEntity(_x:Float, _y:Float, size:Float, angle:Float, color:UInt):Entity
	{
		trace("box");
		var entity = new Entity();
		
		var shape = new BoxShape(size, size, color, 0, 0, true);
		var sprite = new EntitySprite(entity);
		sprite.addChild(shape);
		entity.add(new Gfx(sprite));
		
		var bodyDef = createBodyDef(_x, _y);
		var fixtureDef = createFixtureDef();
		fixtureDef.shape = createBoxShape(size/2, angle);
		entity.add(new Phy(bodyDef, fixtureDef));
		
		return entity;
	}
	
	function createWallEntity(_x:Float, _y:Float, size:Float, color:UInt):Entity
	{
		trace("wall");
		var entity = new Entity();
		
		var shape = new BoxShape(size, size, color);
		var sprite = new EntitySprite(entity);
		sprite.addChild(shape);
		entity.add(new Gfx(sprite));
		
		var bodyDef = createBodyDef(_x, _y, B2BodyType.STATIC_BODY);
		var fixtureDef = createFixtureDef();
		fixtureDef.shape = createBoxShape(size);
		entity.add(new Phy(bodyDef, fixtureDef));
		
		return entity;
	}
	
	function createBoxShape(size:Float, angle:Float=0):B2PolygonShape 
	{
		
		var shape = new B2PolygonShape();
		var halfSize = size / 2;
		shape.setAsBox(size, size);
		return shape;
	}
	
	function createBodyDef(_x:Float, _y:Float, bodyType:B2BodyType=B2BodyType.DYNAMIC_BODY):B2BodyDef
	{
		var bodyDef = new B2BodyDef();
		bodyDef.type = bodyType;
		bodyDef.position.set(_x, _y);
		return bodyDef;
	}
	
	function createFixtureDef(density:Float = 1):B2FixtureDef
	{
		var fixtureDef = new B2FixtureDef();
		var fixtureDef = new B2FixtureDef();
		fixtureDef.density = density;
		return fixtureDef;
	}
	
	function addEntities(nbEntities:UInt=50)
	{
		//entities = new Array<Sprite>();
		
		for (i in 0...nbEntities)
		{
			var _x = Rnd.float(w);
			var _y = Rnd.float(h);
			var size = Math.random() * 10;
			var color = RndColor.rgb(0.25, 0.5);
			var angle = Math.random() * Math.PI * 2;
			
			var entity;
			
			if (Rnd.chance())
			{
				entity = createBallEntity(_x, _y, size, angle, color);
			}
			else
			{
				entity = createBoxEntity(_x, _y, size, angle, color);
			}
			
			entity.add(new RandomMove(1));
			entity.add(new Selectable());
			
			engine.addEntity(entity);
		}
		
		
		var westWall = createWallEntity( -h, 0, h, Colors.WHITE);
		engine.addEntity(westWall);


		var eastWall = createWallEntity( w+h, 0, h, Colors.WHITE);
		engine.addEntity(eastWall);

		
		var northWall = createWallEntity( 0, -w, w, Colors.WHITE);
		engine.addEntity(northWall);
		
		var southWall = createWallEntity( 0, h+w, w, Colors.WHITE);
		engine.addEntity(southWall);
		
		//return maskedLayer;
	}
	
}
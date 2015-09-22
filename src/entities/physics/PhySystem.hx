package entities.physics;

import ash.tools.ListIteratingSystem;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2World;
import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class PhySystem extends ListIteratingSystem<PhyNode>
{
	static public var GRAVITY:B2Vec2 = new B2Vec2();
	static public inline var PERIOD:Float = 1 / 60;

	var world:B2World;
	
	public function new(world, debugSprite:Sprite=null) 
	{
		super(PhyNode, nodeUpdate, nodeAdded, nodeRemoved);
		
		this.world = world;
		
		if (debugSprite != null)
		{
			var debugDraw = new B2DebugDraw();
			debugDraw.setSprite(debugSprite);
			world.setDebugDraw(debugDraw);
		}
	}
	
	override public function update(time:Float)
	{
		//trace("update");
		super.update(time);
		world.step(PERIOD, 8, 3);
	}
	
	
	function nodeUpdate(node:PhyNode, time:Float)
	{
		//node.phy.body.advance(PERIOD);
		//world.step(PERIOD, 8, 3);
	}
	
	
	function nodeAdded(node:PhyNode)
	{
		trace("nodeAdded");
		node.phy.body = world.createBody(node.phy.bodyDef);
		trace(node.phy.body);
		node.phy.body.createFixture(node.phy.fixtureDef);
	}
	
	function nodeRemoved(node:PhyNode)
	{
		trace("nodeRemoved");
		node.phy.body.DestroyFixture(node.phy.body.getFixtureList());
		world.destroyBody(node.phy.body);
	}
	
}
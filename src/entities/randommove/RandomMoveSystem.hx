package entities.randommove;

import ash.core.System;
import ash.tools.ListIteratingSystem;
import box2D.common.math.B2Vec2;
import entities.randommove.RandomMoveNode;
import hxlpers.Rnd;

/**
 * ...
 * @author damrem
 */
class RandomMoveSystem extends ListIteratingSystem<RandomMoveNode>
{

	public function new() 
	{
		super(RandomMoveNode, updateNode);
	}
	
	function updateNode(node:RandomMoveNode, time:Float)
	{
		var body = node.phy.body;
		var mass = body.getMass();
		var xImpulse = mass * Rnd.float( -node.randomMove.range, node.randomMove.range);
		var yImpulse = mass * Rnd.float( -node.randomMove.range, node.randomMove.range);
		body.applyImpulse(new B2Vec2(xImpulse, yImpulse), body.getWorldCenter());
	}
	
}
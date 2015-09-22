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
		super(RandomMoveNode, updateNode, nodeAdded, nodeRemoved);
	}
	
	function updateNode(node:RandomMoveNode, time:Float)
	{
		//node.visual.entitySprite.x += Rnd.float( -node.randomMove.range, node.randomMove.range);
		//node.visual.entitySprite.y += Rnd.float( -node.randomMove.range, node.randomMove.range);
		var currentPos = node.phy.body.getPosition();
		
		var x = currentPos.x + Rnd.float( -node.randomMove.range, node.randomMove.range);
		var y = currentPos.y + Rnd.float( -node.randomMove.range, node.randomMove.range);
		node.phy.body.setPosition(new B2Vec2(x, y));
	}
	
	function nodeAdded(node:RandomMoveNode)
	{
		//trace("nodeAdded(" + node);
	}
	
	function nodeRemoved(node:RandomMoveNode)
	{
		//trace("nodeRemoved(" + node);
	}
	
}
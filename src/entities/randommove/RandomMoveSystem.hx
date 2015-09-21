package entities.randommove;

import ash.core.System;
import ash.tools.ListIteratingSystem;
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
		node.visual.sprite.x += Rnd.float( -node.randomMove.range, node.randomMove.range);
		node.visual.sprite.y += Rnd.float( -node.randomMove.range, node.randomMove.range);
	}
	
	function nodeAdded(node:RandomMoveNode)
	{
		trace("nodeAdded(" + node);
	}
	
	function nodeRemoved(node:RandomMoveNode)
	{
		trace("nodeRemoved(" + node);
	}
	
}
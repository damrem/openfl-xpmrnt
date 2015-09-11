package entities;

import ash.core.System;
import ash.tools.ListIteratingSystem;
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
	
	private function updateNode(node:RandomMoveNode, time:Float)
	{
		node.visual.display.x += Rnd.float( -node.randomMove.range, node.randomMove.range);
		node.visual.display.y += Rnd.float( -node.randomMove.range, node.randomMove.range);
	}
	
}
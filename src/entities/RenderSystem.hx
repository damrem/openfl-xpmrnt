package entities;

import ash.core.System;
import ash.tools.ListIteratingSystem;
import openfl.display.DisplayObjectContainer;

/**
 * ...
 * @author damrem
 */
class RenderSystem extends ListIteratingSystem<RenderNode>
{

	var layer:DisplayObjectContainer;
	
	public function new(layer:DisplayObjectContainer) 
	{
		super(RenderNode, updateNode, nodeAdded, nodeRemoved);
		this.layer = layer;
	}
	
	function nodeAdded(node:RenderNode) 
	{
		layer.addChild(node.visual.display);
	}
	
	function nodeRemoved(node:RenderNode) 
	{
		layer.removeChild(node.visual.display);
	}
	
	function updateNode(node:RenderNode, time:Float)
	{
		
	}
	
	
	
}
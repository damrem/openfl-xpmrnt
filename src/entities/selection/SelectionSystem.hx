package entities.selection;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;
import entities.selection.SelectableNode;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

/**
 * ...
 * @author damrem
 */
class SelectionSystem extends System
{

	var selectableNodes:NodeList<SelectableNode>;
	var selectedNodes:NodeList<SelectedNode>;
	
	public function new() 
	{
		super();
		
		selectableNodes.nodeAdded(onSelectableNodeAdded);
		selectedNodes.nodeRemoved(onSelectableNodeRemoved);
		
		selectedNodes.nodeAdded(onSelectedNodeAdded);
		selectedNodes.nodeRemoved(onSelectedNodeRemoved);
	}
	
	function onSelectableNodeAdded(selectableNode:SelectableNode)
	{
		selectableNode.visual.display.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
		selectableNode.visual.display.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
	}
	
	private function onRollOver(e:MouseEvent):Void 
	{
		cast(e.currentTarget, Sprite).alpha = 0.25;
	}
	
	private function onRollOver(e:MouseEvent):Void 
	{
		cast(e.currentTarget, Sprite).alpha = 1;
	}
	
	function onSelectableNodeRemoved(selectableNode:SelectableNode)
	{
		selectableNode.visual.display.removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
		selectableNode.visual.display.removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
	}
	
	function onSelectedNodeAdded(selectedNode:SelectedNode)
	{
		
	}
	
	function onSelectedNodeRemoved(selectedNode:SelectedNode)
	{
		
	}
	
	override public function addToEngine(engine:Engine)
	{
		selectableNodes = engine.getNodeList(SelectableNode);
		selectedNodes = engine.getNodeList(SelectedNode);
	}
	
	override public function removeFromEngine(engine:Engine)
	{
		selectableNodes = null;
		selectedNodes = null;
	}
	
}
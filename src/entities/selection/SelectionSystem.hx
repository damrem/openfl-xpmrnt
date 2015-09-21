package entities.selection;

import ash.core.Engine;
import ash.core.NodeList;
import ash.core.System;
import ash.tools.ListIteratingSystem;
import entities.randommove.RandomMove;
import entities.selection.SelectableNode;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.filters.GlowFilter;

/**
 * ...
 * @author damrem
 */
class SelectionSystem extends ListIteratingSystem<SelectableNode>
{

	var glow:GlowFilter;
	
	public function new() 
	{
		super(SelectableNode, updateNode, added, removed);
		glow = new GlowFilter(0xffffff);
	}
	
	function added(node:SelectableNode)
	{
		node.visual.sprite.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
		node.visual.sprite.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
		node.visual.sprite.addEventListener(MouseEvent.CLICK, onClick);
		node.visual.sprite.buttonMode = true;
	}
	
	function removed(node:SelectableNode)
	{
		node.visual.sprite.removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
		node.visual.sprite.removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
		node.visual.sprite.removeEventListener(MouseEvent.CLICK, onClick);
		node.visual.sprite.buttonMode = false;
	}
	
	private function onClick(e:MouseEvent):Void 
	{
		var sprite = cast(e.currentTarget, EntitySprite);
		var entity = sprite.entity;
		
		var selectable = cast(entity.get(Selectable), Selectable);
		selectable.isSelected = !selectable.isSelected;
		
		if (entity.get(RandomMove) != null)
		{
			trace("remove");
			entity.remove(RandomMove);
			trace(entity.components);
		}
		else
		{
			trace("add");
			entity.add(new RandomMove());
			trace(entity.components);
		}
	}
	
	function onRollOver(e:MouseEvent):Void 
	{
		cast(e.currentTarget, EntitySprite).alpha = 0.25;
	}
	
	function onRollOut(e:MouseEvent):Void 
	{
		cast(e.currentTarget, EntitySprite).alpha = 1;
	}
	
	function updateNode(node:SelectableNode, time:Float)
	{
		if (node.selectable.isSelected)
		{
			node.visual.sprite.filters = [glow];
		}
		else
		{
			node.visual.sprite.filters = null;
		}
	}
	
	
}
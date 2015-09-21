package entities.selection;

import ash.core.Node;
import entities.rendering.SpriteComponent;
import entities.selection.Selectable;

/**
 * ...
 * @author damrem
 */
class SelectableNode extends Node<SelectableNode>
{
	public var spriteComponent:SpriteComponent;
	public var selectable:Selectable;
}
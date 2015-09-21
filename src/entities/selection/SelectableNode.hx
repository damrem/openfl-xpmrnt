package entities.selection;

import ash.core.Node;
import entities.rendering.Visual;
import entities.selection.Selectable;

/**
 * ...
 * @author damrem
 */
class SelectableNode extends Node<SelectableNode>
{
	public var visual:Visual;
	public var selectable:Selectable;
}
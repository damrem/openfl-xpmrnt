package entities.selection;
import ash.core.Node;
import entities.rendering.Visual;

/**
 * ...
 * @author damrem
 */
class SelectedNode extends Node<SelectedNode>
{
	public var visual:Visual;
	public var isSelectable:IsSelectable;
	public var isSelected:IsSelected;
}
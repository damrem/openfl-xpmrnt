package svganimation;

import format.SVG;
import hxlpers.game.Room;
import hxlpers.svg.SVGFrameAnimated;
import hxlpers.svg.SVGFrameAnimation;
import openfl.Assets;

using hxlpers.IntSF;

/**
 * ...
 * @author damrem
 */
class SvgAnimationRoom extends Room
{
	var animated:hxlpers.svg.SVGFrameAnimated;

	public function new(fullWidth:Float, fullHeight:Float, ratio:UInt) 
	{
		super(fullWidth, fullHeight, ratio);
		
		animated = new SVGFrameAnimated();
		
		addFrames("img/tileset", 3, 0, 24, "", "", "svg");
	
		addChild(animated);
		animated.playAnimation("anim");
	}
	
	function addFrames(assetPath:String, iLength:Int, iStart:Int, iEnd:Int, prefix:String = "", suffix:String = "", extension:String = "svg")
	{
		//var iLength = Std.string(iEnd).length;
		var fixedILength = iLength > 0;
		trace(fixedILength);
		var animation = new SVGFrameAnimation();
		for (i in iStart...iEnd + 1)
		{
			var iString:String = Std.string(i);
			if (fixedILength)
			{
				iString = i.toFixedLengthString(iLength);
			}
			else
			{
				iString = Std.string(i);
			}
			var filePath = assetPath + "/" + prefix + iString + suffix + "." + extension;
			trace(filePath);
			var svg = new SVG(Assets.getText(filePath));
			animation.addFrame(svg);
			
		}
		
		animated.addAnimation("anim", animation);
	}
	
	override public function update()
	{
		animated.update();
		super.update();
	}
	
}
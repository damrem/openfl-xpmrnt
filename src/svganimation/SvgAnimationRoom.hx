package svganimation;

import format.SVG;
import hxlpers.game.Room;
import hxlpers.svg.SVGFrameAnimated;
import hxlpers.svg.SVGFrameAnimation;
import openfl.Assets;
import openfl.errors.Error;

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
		
		animated.addAnimation("anim01", createAnimation("img/tileset", 3, 0, 24, "", "", "svg"));
		animated.addAnimation("anim02", createAnimation("img/tileset", 3, 51, 52, "", "", "svg"));
		
		animated.addAnimation("anim03", createAnimation("img/tileset", 3, 101, 124, "", "", "svg"));
		animated.addAnimation("anim04", createAnimation("img/tileset", 3, 151, 152, "", "", "svg"));
		
		animated.addAnimation("anim05", createAnimation("img/tileset", 3, 201, 224, "", "", "svg"));
		animated.addAnimation("anim06", createAnimation("img/tileset", 3, 251, 252, "", "", "svg"));
		
		animated.addAnimation("anim07", createAnimation("img/tileset", 3, 301, 324, "", "", "svg"));
		animated.addAnimation("anim08", createAnimation("img/tileset", 3, 351, 352, "", "", "svg"));
		
		animated.addAnimation("anim09", createAnimation("img/tileset", 3, 401, 401, "", "", "svg"));
		animated.addAnimation("anim10", createAnimation("img/tileset", 3, 451, 458, "", "", "svg"));
		animated.addAnimation("anim11", createAnimation("img/tileset", 3, 460, 463, "", "", "svg"));
		animated.addAnimation("anim12", createAnimation("img/tileset", 3, 468, 482, "", "", "svg"));
		animated.addAnimation("anim13", createAnimation("img/tileset", 3, 481, 482, "", "", "svg"));
		animated.addAnimation("anim14", createAnimation("img/tileset", 3, 491, 494, "", "", "svg"));
		
		animated.addAnimation("anim15", createAnimation("img/tileset", 3, 551, 559, "", "", "svg"));
		animated.addAnimation("anim16", createAnimation("img/tileset", 3, 401, 401, "", "", "svg"));
		animated.addAnimation("anim17", createAnimation("img/tileset", 3, 650, 660, "", "", "svg"));
	
		addChild(animated);
		animated.playAnimation("anim05");
	}
	
	function createAnimation(assetPath:String, iLength:Int, iStart:Int, iEnd:Int, prefix:String = "", suffix:String = "", extension:String = "svg")
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
		
		return animation;
		
		
	}
	
	
	override public function update()
	{
		animated.update();
		super.update();
	}
	
}
package hxlpers.svg;
import format.SVG;
import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class SVGFrameAnimation extends Sprite
{
	var frames:Array<SVG>;
	var isPlaying:Bool;
	var currentFrameId:Int;
	
	public function new(initialFramId=0) 
	{
		super();
		frames = new Array<SVG>();
		currentFrameId = initialFramId;
	}
	
	public function addFrame(frame:SVG):SVG
	{
		frames.push(frame);
		return frame;
	}
	
	public function addFrames(frames:Array<SVG>)
	{
		this.frames.concat(frames);
	}
	
	public function play()
	{
		isPlaying = true;
	}
	
	public function pause()
	{
		isPlaying = false;
	}
	
	public function update()
	{
		graphics.clear();
		currentFrameId++;
		if (currentFrameId >= frames.length)
		{
			currentFrameId = 0;
		}
		
		frames[currentFrameId].render(graphics);
	}
	
}
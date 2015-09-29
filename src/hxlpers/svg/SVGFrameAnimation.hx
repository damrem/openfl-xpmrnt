package hxlpers.svg;
import format.SVG;
import msignal.Signal.Signal0;
import openfl.display.Sprite;

/**
 * ...
 * @author damrem
 */
class SVGFrameAnimation extends Sprite
{
	var frames:Array<SVG>;
	var isPlaying:Bool;
	var currentFrameId:Int=0;
	var playMode:AnimationPlayMode;
	
	var _iterationEnded:Signal0;
	var nbLoops:UInt;
	var iterationEnded(get, null):Signal0;
	
	/**
	 * 
	 * @param	initialFramId
	 * @param	nbLoops	0 for infinite.
	 */
	public function new(nbLoops:UInt=0, playMode:AnimationPlayMode = null) 
	{
		super();
		
		this.nbLoops = nbLoops;
		
		if (playMode == null)
		{
			playMode = Normal;
		}
		this.playMode = playMode;
		
		frames = new Array<SVG>();
		
		_iterationEnded = new Signal0();
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
			_iterationEnded.dispatch();
			currentFrameId = 0;
		}
		
		frames[currentFrameId].render(graphics);
	}
	
	function get_iterationEnded():Signal0 
	{
		return iterationEnded;
	}
	
}

enum AnimationPlayMode {
	Normal;
	Yoyo;
}

enum YoyoDirection {
	Forward;
	Backward;
}
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
	public var playMode:AnimationPlayMode;
	
	var _iterationEnded:Signal0;
	var nbLoops:UInt;
	var currentLoop:UInt;
	var iterationEnded(get, null):Signal0;
	
	/**
	 * 
	 * @param	initialFramId
	 * 
	 */
	public function new() 
	{
		super();
		
		playMode = Normal;
		
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
	
	/**
	 * @param	nbLoops	0 for infinite.
	 */
	public function play(nbLoops:UInt=0)
	{
		this.nbLoops = nbLoops;
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
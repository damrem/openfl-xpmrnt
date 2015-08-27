package hxlpers;
import msignal.Signal.Signal1;

using hxlpers.SIntPool;


abstract SInt({value:Int, signal:Signal1<Int>})
{
	//public var signal(get, never):Signal1<Int>;
	
	public function new(v:{value:Int, signal:Signal1<Int>})
	{
		this = v;
		//signal = new Signal1<Int>();
		//this.setSignal();
	}
	
	
	/*public function get_signal():Signal1<Int>
	{
		return getSignal("toto");
	}*/
}


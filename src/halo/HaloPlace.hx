package halo;
import hxlpers.colors.RndColor;
import hxlpers.game.Place;
import hxlpers.Rnd;
import hxlpers.shapes.BoxShape;
import hxlpers.shapes.DiskShape;
import hxlpers.shapes.ShortcutShape;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.BlendMode;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;
using hxlpers.display.ShapeSF;
using hxlpers.display.SpriteSF;
using hxlpers.display.BitmapDataSF;

/**
 * ...
 * @author damrem
 */
class HaloPlace extends Place
{
	var entities:Array<Sprite>;
	var nbShapes:UInt = 100;
	var halo:Halo;
	var haloRendering:BitmapData;
	var haloLayer:Sprite;
	var masked:openfl.display.Sprite;
	
	public function new(fullWidth:Float, fullHeight:Float, ratio:UInt) 
	{
		trace("new", fullWidth, fullHeight, ratio);
		super(fullWidth, fullHeight, ratio);
		trace(w, h);
		
		masked = new Sprite();
		//addChild(masked);
		
		
		haloLayer = new Sprite();
		halo = new Halo([{intensity:1, radius:25}, {intensity:0.5, radius:30}]);
		//halo.disk(50, 0xffffff);
		//halo.alpha = 0.5;
		//masked.mask = halo;
		haloLayer.addChild(halo);
		
		var bg = new Sprite();
		bg.rect(w, h, RndColor.rgb());
		
		masked.addChild(bg);
		
		haloRendering = new BitmapData(Math.ceil(w), Math.ceil(h), true, 0);
		addChild(new Bitmap(haloRendering));

		entities = new Array<Sprite>();
		
		for (i in 0...nbShapes)
		{
			var size = Math.random() * 25;
			//var color = RndColor.RR(0, 0.25)+RndColor.GG(0.5,1)+RndColor.BB(0.25, 0.5);
			var color = RndColor.rgb(0.25, 0.5);
			//trace(color);
			var shape:ShortcutShape;
			var sprite = new Sprite();
			
			if (Rnd.chance())
			{
				shape = new DiskShape(size, color);
			}
			else
			{
				shape = new BoxShape(size, size, color);
				shape.rotation = Math.random() * 360;
			}
			sprite.addChild(shape);
			//sprite.alpha = Math.random();
			sprite.x = Rnd.float(w);
			sprite.y = Rnd.float(h);
			sprite.buttonMode = true;
			
			
			sprite.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			
			
		
			
			
			masked.addChild(sprite);
			entities.push(sprite);
		}
		
		var fg = new Sprite();
		fg.rect(w, h);
		fg.alpha = 0;
		fg.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		addChild(fg);
	}
	
	
	private function onMouseMove(e:MouseEvent):Void 
	{
		halo.x = Math.round(e.stageX / ratio);
		halo.y = Math.round(e.stageY / ratio);
	}
	
	function onRollOver(e:MouseEvent):Void 
	{
		cast(e.currentTarget, Sprite).alpha = 0.5;
	}
	
	override public function update()
	{
		for (shape in entities)
		{
			if (Rnd.chance(0.01))
			{
				shape.x += Rnd.float( -1, 1);
				shape.y += Rnd.float( -1, 1);
				//shape.alpha += Rnd.float( -0.1, 0.1);
				shape.rotation += Rnd.float( -5, 5);
			}
		}
		
		
	}
	
	override public function render()
	{
		super.render();
		
		haloRendering.clear(0xff000000);
		haloRendering.draw(haloLayer);
		
		haloRendering.draw(masked, null, null, BlendMode.MULTIPLY);
		//++
	}
	
}
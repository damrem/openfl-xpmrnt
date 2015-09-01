package halo;
import halo.Halo;
import hxlpers.colors.ColorComponent;
import hxlpers.colors.RGBColor;
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
import openfl.geom.Matrix;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.utils.ByteArray;
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
	var halo2:Halo;
	var bufferFrom:ByteArray;
	var bufferTo:ByteArray;
	var preRendering:BitmapData;
	var prepreRendering:BitmapData;
	
	
	public function new(fullWidth:Float, fullHeight:Float, ratio:UInt) 
	{
		trace("new", fullWidth, fullHeight, ratio);
		super(fullWidth, fullHeight, ratio);
		trace(w, h);
		
		
		bufferTo = new ByteArray();
		
		preRendering = new BitmapData(cast(w), cast(h), true, 0);
		prepreRendering = new BitmapData(cast(w), cast(h), true, 0);

		addChild(new Bitmap(preRendering));
		
		masked = new Sprite();
		//addChild(masked);
		
		
		haloLayer = new Sprite();
		halo = new Halo();
		halo2 = new Halo();
		halo2.x = w / 2;
		halo2.y = h / 2;
		//halo.disk(50, 0xffffff);
		//halo.alpha = 0.5;
		//masked.mask = halo;
		haloLayer.addChild(halo);
		haloLayer.addChild(halo2);
		
		var bg = new Sprite();
		bg.rect(w, h, RndColor.rgb());
		
		masked.addChild(bg);
		addChild(masked);
		
		haloRendering = new BitmapData(Math.ceil(w), Math.ceil(h), true, 0);
		//addChild(new Bitmap(haloRendering));

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
		
		//halo2.x += Rnd.float( -1, 1);
		//halo2.y += Rnd.float( -1, 1);
	}
	var pointZero:Point = new Point();
	var haloBuffer:ByteArray;
	override public function render()
	{
		haloRendering.clear(0);
		haloRendering.draw(haloLayer);
//		rendering.draw(haloRendering);
		//prepreRendering.clear(0);
		//prepreRendering.draw(masked);
		
		//preRendering.copyPixels(prepreRendering, rendering.rect, pointZero, haloRendering, pointZero, false);
		
		super.render();
		
		
		
		//haloBuffer = haloRendering.getPixels();
		
		bufferFrom = rendering.getAllPixels();
		bufferFrom.position = 0;
		
		haloBuffer = haloRendering.getAllPixels();
		haloBuffer.position = 0;
		
		bufferTo.position = 0;
		
		while (bufferFrom.position < bufferFrom.length)
		{
			var argb = bufferFrom.readUnsignedInt();
			var rgb = argb & ColorComponent.ALPHA_NEGATIVE;
			var a = haloBuffer.readUnsignedInt() & ColorComponent.ALPHA_MASK;
			bufferTo.writeUnsignedInt(a+rgb);
		}
		trace(bufferFrom.length, bufferTo.length);
		
		trace(rendering.width * rendering.height * 4);
		bufferTo.position = 0;
		rendering.setPixels(rendering.rect, bufferTo);
		
		//haloRendering.clear(0xff000000);
		
		/*
		for (i in 0...haloLayer.numChildren)
		{
			var halo = haloLayer.getChildAt(i);
			haloRendering.draw(halo, new Matrix(1, 0, 0, 1, halo.x, halo.y));
		}
		*/
		
		//haloRendering
		
		//haloRendering.draw(masked, null, null, BlendMode.MULTIPLY);
		//++
	}
	
}
package halo;
import halo.Halo;
import hxlpers.colors.ColorComponent;
import hxlpers.colors.RndColor;
import hxlpers.game.BlendingLayer;
import hxlpers.game.Layer;
import hxlpers.game.Room;
import hxlpers.Rnd;
import hxlpers.shapes.BoxShape;
import hxlpers.shapes.DiskShape;
import hxlpers.shapes.ShortcutShape;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;
import openfl.utils.ByteArray;
using hxlpers.display.ShapeSF;
using hxlpers.display.SpriteSF;
using hxlpers.display.BitmapDataSF;

/**
 * ...
 * @author damrem
 */
class HaloRoom extends Room
{
	var entities:Array<Sprite>;
	var nbShapes:UInt = 100;

	var halo:Halo;
	var halo2:Halo;
	
	
	var masker:Layer;
	var masked:Layer;
	var finalLayer:Layer;
	
	public function new(?zone:Rectangle) 
	{
		
		super(zone);
		
		
		//	the scene
		masked = createMaskedLayer();
		
		//	the halos
		masker = createMaskerLayer();
		
		var miniViewPort = new Rectangle(0, 0, Conf.VIEW_PORT.width / Conf.PIXEL_SIZE, Conf.VIEW_PORT.height / Conf.PIXEL_SIZE);
		
		finalLayer = addLayer(new BlendingLayer(miniViewPort));
		finalLayer.rectangle(miniViewPort, 0xFF000000);
		
		finalLayer.addChild(finalLayer.getBitmap());
		trace(finalLayer.getBitmap().parent);
		
		
		var fg = addLayer(new Layer(true, false));
		
		fg.rectangle(Conf.VIEW_PORT, 0x00000000);
		fg.alpha = 0;
		fg.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		
		
		
	}
	
	function createMaskerLayer():Layer
	{
		masker = new Layer();
		

		halo = new Halo();
		
		halo2 = new Halo();
		halo2.x = zone.width / 2;
		halo2.y = zone.height / 2;
		
		masker.addChild(halo);
		masker.addChild(halo2);
		
		return masker;
	}
	
	function createMaskedLayer():Layer
	{
		var layer = new Layer();
		layer.rectangle(Conf.VIEW_PORT, 0xFF000000);
		
		var bg = new Sprite();
		bg.rect(zone.width, zone.height, RndColor.rgb());
		layer.addChild(bg);
		
		entities = new Array<Sprite>();
		for (i in 0...nbShapes)
		{
			var size = Math.random() * 25;
			var color = RndColor.rgb(0.25, 0.5);
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
			sprite.x = zone.x + Rnd.float(zone.width);
			sprite.y = zone.y + Rnd.float(zone.height);
			sprite.buttonMode = true;
			sprite.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			layer.addChild(sprite);
			entities.push(sprite);
		}
		
		return layer;
	}
	
	
	function onMouseMove(e:MouseEvent):Void 
	{
		halo.x = Math.round(e.stageX);
		halo.y = Math.round(e.stageY);
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
	
	override public function render()
	{
		var maskedBytes = masked.getBytes(true);
		var maskerBytes = masker.getBytes(true);
		
		var finalBytes = new ByteArray();
		
		while (finalBytes.position < maskerBytes.length)
		{
			var a = maskerBytes.readUnsignedInt() & ColorComponent.ALPHA_MASK;
			var rgb = maskedBytes.readUnsignedInt() & ColorComponent.ALPHA_NEGATIVE;
			finalBytes.writeUnsignedInt(a | rgb);
		}
		
		
		var rect = finalLayer.data.rect;
		finalBytes.position = 0;
		trace(finalBytes.position + '/' + finalBytes.length);
		trace(rect.width + " * " + rect.height + "=" + rect.width * rect.height);
		trace(rect.width * rect.height * 4);
		finalLayer.data.setPixels(rect, finalBytes);
		
		super.render();

	}
	
}
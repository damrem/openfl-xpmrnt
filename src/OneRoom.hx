package;
import hxlpers.colors.RndColor;
import hxlpers.game.ColoredBitmapData;
import hxlpers.game.Layer;
import hxlpers.game.Room;
import hxlpers.Rnd;
import hxlpers.shapes.BoxShape;
import hxlpers.shapes.DiskShape;
import hxlpers.shapes.ShortcutShape;
import motion.Actuate;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;

/**
 * ...
 * @author damrem
 */
class OneRoom extends Room
{
	var entities:Array<Sprite>;
	var nbShapes:UInt = 100;
	
	public function new(fullWidth:Float, fullHeight:Float, ratio:UInt) 
	{
		trace("new", fullWidth, fullHeight, ratio);
		super(fullWidth, fullHeight, ratio);
		trace(w, h);

		entities = new Array<Sprite>();
		
		var layer = addLayer(new Layer(new ColoredBitmapData(w, h, true, 0xFFFF0000), true, true));
		
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
			sprite.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			
			
			layer.addChild(sprite);
			entities.push(sprite);
		}
		
		//addLayer(layer);
	}
	
	function onRollOver(e:MouseEvent):Void 
	{
		var sprite = cast(e.currentTarget, Sprite);
		sprite.alpha = 0.5;
		Actuate.tween(defaultCamera, 1, { zoomLevel:2 } );
		Actuate.tween(defaultCamera.pos, 1, { x:sprite.x, y:sprite.y });
	}
	
	function onRollOut(e:MouseEvent):Void 
	{
		
		cast(e.currentTarget, Sprite).alpha = 1;
		Actuate.tween(defaultCamera, 1, { zoomLevel:1 } );
		Actuate.tween(defaultCamera.pos, 1, { x:defaultCamera.initialPos.x, y:defaultCamera.initialPos.y });
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
		super.update();
	}
	
}
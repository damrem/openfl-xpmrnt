package tiledbox2d;
import box2D.collision.shapes.B2PolygonShape;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2BodyType;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;

/**
 * ...
 * @author damrem
 */
class BodyCreator
{
	var world:B2World;

	public function new(world:B2World) 
	{
		this.world = world;
		
	}
	
	public function createBoxBody(x:Float, y:Float, w:Float, h:Float):B2Body
	{
		trace("createBody",x,y,w,h);
		var bodyDef = createBodyDef(x, y, B2BodyType.STATIC_BODY);
		
		var fixtureDef = createFixtureDef();
		fixtureDef.shape = createBoxShape(w, h);
		
		var body = world.createBody(bodyDef);
		body.createFixture(fixtureDef);
		
		body.setPosition(new B2Vec2(x, y));
		
		return body;
	}
	
	function createBoxShape(w:Float, h:Float):B2PolygonShape 
	{
		var shape = new B2PolygonShape();
		shape.setAsBox(w, h);
		return shape;
	}
	
	function createFixtureDef(density:Float = 1):B2FixtureDef
	{
		var fixtureDef = new B2FixtureDef();
		fixtureDef.density = density;
		return fixtureDef;
	}
	
	function createBodyDef(_x:Float, _y:Float, bodyType:B2BodyType=B2BodyType.DYNAMIC_BODY):B2BodyDef
	{
		var bodyDef = new B2BodyDef();
		bodyDef.type = bodyType;
		bodyDef.position.set(_x, _y);
		return bodyDef;
	}
	
}
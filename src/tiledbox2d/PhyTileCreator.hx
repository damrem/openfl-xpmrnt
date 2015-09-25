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
class PhyTileCreator
{
	var world:B2World;
	var directionMap:Map<Direction, UInt>;
	
	public static inline var TOP:UInt = 1;
	public static inline var TOP_RIGHT:UInt = 2;
	public static inline var RIGHT:UInt = 4;
	public static inline var BOTTOM_RIGHT:UInt = 8;
	public static inline var BOTTOM:UInt = 16;
	public static inline var BOTTOM_LEFT:UInt = 32;
	public static inline var LEFT:UInt = 64;
	public static inline var TOP_LEFT:UInt = 128;

	public function new(world:B2World) 
	{
		this.world = world;
		directionMap = new Map<Direction, UInt>();
		directionMap.set(Top, TOP);
		directionMap.set(TopRight, TOP_RIGHT);
		directionMap.set(Right, RIGHT);
		directionMap.set(BottomRight, BOTTOM_RIGHT);
		directionMap.set(Bottom, BOTTOM);
		directionMap.set(BottomLeft, BOTTOM_LEFT);
		directionMap.set(Left, LEFT);
		directionMap.set(TopLeft, TOP_LEFT);
		//createBlockBody(10, 10, [Top, Left, Bottom, Right], 16);
	}
	
	public function createBody(x:Float, y:Float, directionBits:UInt, size:Float)
	{
		trace("createBlockBody", x, y, directionBits, size);
		var bodyDef = createBodyDef(x, y, B2BodyType.STATIC_BODY);
		
		var fixtureDef = createFixtureDef();
		fixtureDef.shape = createShape(directionBits, size);
		
		var body = world.createBody(bodyDef);
		body.createFixture(fixtureDef);
		
		body.setPosition(new B2Vec2(x, y));
		
		return body;
	}
	
	function createShape(directionBits:UInt, size:Float):B2PolygonShape
	{
		trace("createBlockShape", directionBits, size);
		var halfSize = size / 2;
		var vertices:Array<B2Vec2> = [];
		
		var directions:Array<UInt> = [];
		
		//trace(directionMap.keys());
		
		for (direction in directionMap.keys())
		{
			trace(direction, directionMap.get(direction));
			trace(directionBits & directionMap.get(direction));
			if (directionBits & directionMap.get(direction) > 0)
			{
				var vertex = getDirectionVec2(direction, halfSize);
				trace(vertex.x, vertex.y);
				vertices.push(vertex);
			}
		}
		
		trace(vertices);
		
		var shape = new B2PolygonShape();
		shape.setAsArray(vertices);
		return shape;
	}
	
	function getDirectionVec2(direction:Direction, multiplier:Float = 1):B2Vec2
	{
		var t = -multiplier;
		var r = multiplier;
		var b = multiplier;
		var l = -multiplier;
		
		switch(direction)
		{
			case Top: 			return new B2Vec2(0, t);
			case TopRight: 		return new B2Vec2(r, t);
			case Right: 		return new B2Vec2(r, 0);
			case BottomRight: 	return new B2Vec2(r, b);
			case Bottom: 		return new B2Vec2(0, b);
			case BottomLeft: 	return new B2Vec2(l, b);
			case Left: 			return new B2Vec2(l, 0);
			case TopLeft: 		return new B2Vec2(l, t);
		}
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

enum Direction {
	Top;
	TopRight;
	Right;
	BottomRight;
	Bottom;
	BottomLeft;
	Left;
	TopLeft;
}

typedef DirectionDef = {
	var direction:Direction;
	var bit:UInt;
}
extends CharacterBody2D

class_name Entity


enum PlayerState {
	PLAYER_ON_GROUND,
	PLAYER_TOUCHED_GROUND,
	PLAYER_ON_LADDER,
	PLAYER_JUMPING,
	PLAYER_IN_AIR,
	PLAYER_WALKING,
	PLAYER_RUNNING
}

enum EntityState {
	ENTITY_ON_GROUND,
	ENTITY_ON_LADDER,
	ENTITY_IN_AIR,
	ENTITY_WALKING,
	ENTITY_RUNNING
}


enum CollisionType {
	NO_COLLISION,
	COLLISION_WITH_GROUND,
	COLLISION_WITH_LADDER,
	COLLISION_WITH_OBJECT
}

@export var direction: Vector2i = Vector2i(0, 0)
@export var speed: Vector2 = Vector2(5.0, 5.0)
@export var gravity: int = 5
@export var jump_strength: int = 4


@onready var player_status_vertical = PlayerState.PLAYER_IN_AIR
@onready var collisions_types: Array[CollisionType] = []
@onready var collisions_positions: Array[Vector2i] = [] 

@export var DEBUG: bool = true
@export var IS_PLAYER: bool = false

@export var jump_component: JumpComponent

@onready var raycasts_below: Array[RayCast2D] = []

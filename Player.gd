extends Node2D

enum PlayerState {
	PLAYER_ON_GROUND,
	PLAYER_ON_LADDER,
	PLAYER_IN_AIR,
	PLAYER_WALKING,
	PLAYER_RUNNING
}

enum CollisionType {
	NO_COLLISION,
	COLLISION_WITH_GROUND,
	COLLISION_WITH_LADDER,
	COLLISION_WITH_OBJECT
}


@onready var direction: Vector2i = Vector2i(0, 0)
@onready var speed: Vector2 = Vector2(5.0, 5.0)
@onready var velocity: Vector2 = Vector2(0.0, 0.0)
@onready var player_status_vertical = PlayerState.PLAYER_IN_AIR
@onready var collisions_types: Array[CollisionType] = []
@onready var collisions_positions: Array[Vector2i] = [] 

func _ready() -> void:
	pass

func get_input_direction_x() -> int:
	var input_direction: int = Input.get_axis("left","right")
	#print(input_direction)
	return input_direction
	
func get_input_direction_y() -> int:
	var input_direction: int = Input.get_axis("up","down")
	return input_direction
	
func get_input_direction_xy() -> Vector2i:
	var input_direction: Vector2i = Vector2i(get_input_direction_x(),get_input_direction_y())
	return input_direction


func _on_area_2d_area_entered(area):
	if area.is_in_group("ground_tile"):
		print("colliding with ground at [x: ", position.x, "| y: ", position.y, "]")
		collisions_positions.append(Vector2i(position.x, position.y))
		collisions_types.append(CollisionType.COLLISION_WITH_GROUND)
		
		if player_status_vertical == PlayerState.PLAYER_IN_AIR: player_status_vertical = PlayerState.PLAYER_ON_GROUND

func _process(delta) -> void:
	direction = get_input_direction_xy()


	move_local_x(direction.x * speed.x, true)
	
	if (player_status_vertical == PlayerState.PLAYER_IN_AIR) or (player_status_vertical == PlayerState.PLAYER_ON_LADDER): 
		if (player_status_vertical == PlayerState.PLAYER_IN_AIR):
			direction.y = 1; speed.y = 0.8
		move_local_y(direction.y * speed.y, true)
		
	collisions_positions.clear()
	collisions_types.clear()


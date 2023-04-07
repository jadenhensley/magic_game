extends Entity

class_name Player



func _ready() -> void:
	for i in range(6):
		raycasts_below.append(RayCast2D.new())
		raycasts_below[i-1].position.x = 12 * (i-1)
		raycasts_below[i-1].position.y = 106
	if (jump_component == null) and (DEBUG):
		print("[In Player] No JumpComponent was provided.")
		assert (jump_component != null)
	if (len(raycasts_below) == 0) and (DEBUG):
		print("[In Player] No Raycasts were provided. (raycasts_below)")
		assert (len(raycasts_below) > 0)

func _draw() -> void:
	pass
#	for raycast in raycasts_below:
#		draw_rect(Rect2(raycast.position.x, raycast.position.y,5, 5), Color(1,0,0), true)

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
	if area.is_in_group("ground_tile") and (player_status_vertical != PlayerState.PLAYER_ON_GROUND):
		if (DEBUG):
			print("colliding with ground at [x: ", position.x, ", y: ", position.y, "]")
		collisions_positions.append(Vector2i(position.x, position.y))
		collisions_types.append(CollisionType.COLLISION_WITH_GROUND)
		
#		if player_status_vertical in [PlayerState.PLAYER_IN_AIR, PlayerState.PLAYER_JUMPING, PlayerState.PLAYER_ON_LADDER]:
#			player_status_vertical = PlayerState.PLAYER_TOUCHED_GROUND

func _process(delta) -> void:
	direction = get_input_direction_xy()
	
	if (Input.get_action_strength("run")):
		velocity.x = speed.x * 1.4 * direction.x
	else:
		velocity.x = speed.x * direction.x

#	move_local_x(direction.x * speed.x, true)
	move_and_slide()
	
#	if (player_status_vertical == PlayerState.PLAYER_IN_AIR) or (player_status_vertical == PlayerState.PLAYER_ON_LADDER): 
#		if (player_status_vertical == PlayerState.PLAYER_IN_AIR):
#			direction.y = 1; speed.y = 0.8
#		move_local_y(direction.y * speed.y, true)
#
#	collisions_positions.clear()
#	collisions_types.clear()


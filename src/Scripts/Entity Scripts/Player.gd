extends Entity

class_name Player

# TODO: 
# - get bullets working with current cursor system
# - allow for second cursor mode with controller that behaves more like mouse 
# and is not locked in the player's radius.
# - program inventory

@export var cursor_sprite: Sprite2D

@onready var gamepad_or_keyboard: String = "keyboard"
@onready var bullets_array: Array = []
@onready var magic_timer_usage: Timer = Timer.new()
@onready var magic_timer_cooldown: Timer = Timer.new()

@onready var magic_timer_label = $Camera2D/LabelMagicTimer
@onready var magic_timer_label_text = "MAGIC USAGE: %d \nMAGIC COOLDOWN: %d"

enum ANIMATION_STATE {
	IDLE,
	WALKING,
	JUMPING,
	FALLING,
}

@onready var animation_state: ANIMATION_STATE = ANIMATION_STATE.IDLE

func get_gamepad_axis_data() -> Dictionary:
	var gamepad_id: int
	var joy_axis_left_x_strength: float
	var joy_axis_left_y_strength: float
	var joy_axis_right_x_strength: float
	var joy_axis_right_y_strength: float
	
	if (len(Input.get_connected_joypads()) > 0):
		gamepad_id = Input.get_connected_joypads()[0]
	
	if (gamepad_id != null):
		joy_axis_left_x_strength = Input.get_joy_axis(gamepad_id, JOY_AXIS_LEFT_X)
		joy_axis_left_y_strength = Input.get_joy_axis(gamepad_id, JOY_AXIS_LEFT_Y)
		joy_axis_right_x_strength = Input.get_joy_axis(gamepad_id, JOY_AXIS_RIGHT_X)
		joy_axis_right_y_strength = Input.get_joy_axis(gamepad_id, JOY_AXIS_RIGHT_Y)
	
		return {
			"DATA": {
				"JOY_AXIS_LEFT_STRENGTH": Vector2(joy_axis_left_x_strength, joy_axis_left_y_strength),
				"JOY_AXIS_RIGHT_STRENGTH": Vector2(joy_axis_right_x_strength, joy_axis_right_y_strength)
			}
		}
	else:
		return {
			"DATA": null
		}
		
#func is_gamepad_being_used() -> bool:
#	if Input.is_action_just_pressed("gamepad_all_inputs"):
#		return true
#	if 

func _input(event):
	if (event is InputEventJoypadButton):
		gamepad_or_keyboard = "gamepad"
	if (event is InputEventJoypadMotion):
		gamepad_or_keyboard = "gamepad"
	if (event is InputEventKey):
		gamepad_or_keyboard = "keyboard"
	if (event is InputEventMouseButton):
		gamepad_or_keyboard = "keyboard"		
	if (event is InputEventMouseMotion):
		gamepad_or_keyboard = "keyboard"


func update_cursor() -> void:
	if (gamepad_or_keyboard == "keyboard"):
		var pos = get_local_mouse_position()
		if (pos != null):
			cursor_sprite.position.x = pos.x
			cursor_sprite.position.y = pos.y
	if (gamepad_or_keyboard == "gamepad"):
		var pos = self.get_position_delta()
		pos.x = pos.x + 24; pos.y = pos.y + 48
		cursor_sprite.position.x = pos.x
		cursor_sprite.position.y = pos.y
		cursor_sprite.position = pos + (get_gamepad_axis_data()["DATA"]["JOY_AXIS_RIGHT_STRENGTH"] * 100)

func spawn_bullet(start_pos_not_centered: Vector2, target_pos) -> void:
# TODO. Need to figure this out tomorrow.
	pass

#	var bullet_scene = load("res://src/Scenes/Entity Scenes/bullet.tscn")
#	var bullet = bullet_scene.instantiate()
#	add_child(bullet)
#
#	var start_pos_centered = start_pos_not_centered + Vector2(24, 48)
#
#	bullet.position = start_pos_centered
#	direction = (target_pos - start_pos_centered).normalized()
#	bullet.velocity = direction * 100
#
#	bullets_array.append(bullet)
#	bullet.move_towards(target_pos)
	

func levatation_spell() -> void:

	magic_timer_label.text = magic_timer_label_text % [magic_timer_usage.time_left, magic_timer_cooldown.time_left]

	if (Input.get_action_strength("gamepad_right_trigger") or Input.get_action_strength("left_mouse_button")):
		if (magic_timer_usage.is_stopped() and magic_timer_cooldown.time_left <= 0):
			magic_timer_usage.start()
		
		if (magic_timer_usage.time_left > 1):
			if (magic_timer_cooldown.is_stopped()):
				var start_pos_centered = self.get_position_delta() + Vector2(48, 48)
				direction = (cursor_sprite.position - start_pos_centered)
				velocity = direction * 1.5
	if (not magic_timer_usage.is_stopped() and magic_timer_usage.time_left < 1):
		magic_timer_cooldown.start()
#		else:
#			magic_timer_cooldown.start()
#	if (magic_timer_cooldown.is_stopped()):
#		if (not magic_timer_usage.is_stopped() and magic_timer_usage.time_left > 0):
#			if (Input.get_action_strength("gamepad_right_trigger") or Input.get_action_strength("left_mouse_button")):
#
#				var start_pos_centered = self.get_position_delta() + Vector2(24, 48)
#				direction = (cursor_sprite.position - start_pos_centered)	
#				velocity = direction * 1.5
#		else:
#			magic_timer_usage.stop()
#			magic_timer_cooldown.start()

func _ready() -> void:
	for i in range(6):
		raycasts_below.append(RayCast2D.new())
		raycasts_below[i-1].position.x = 12 * (i-1)
		raycasts_below[i-1].position.y = 106

	
	if (jump_component == null and DEBUG):
		print("[In Player] No JumpComponent was provided.")
		assert (jump_component != null)
	if (len(raycasts_below) == 0 and DEBUG):
		print("[In Player] No Raycasts were provided. (raycasts_below)")
		assert (len(raycasts_below) > 0)
	if (cursor_sprite == null and DEBUG):
		print("[In Player] No Cursor Sprite2D was provided.")
		
	magic_timer_usage.wait_time = 5.0
	magic_timer_cooldown.wait_time = 10.0
	magic_timer_usage.one_shot = true
	magic_timer_cooldown.one_shot = true
	add_child(magic_timer_usage)
	add_child(magic_timer_cooldown)

func _draw() -> void:
	pass
#	for raycast in raycasts_below:
#		draw_rect(Rect2(raycast.position.x, raycast.position.y,5, 5), Color(1,0,0), true)

func animate() -> void:
	var player_animated_sprite: AnimatedSprite2D = get_node("PlayerAnimatedSprite2D")

	if (animation_state == ANIMATION_STATE.IDLE):
		player_animated_sprite.animation = "idle"
	if (animation_state == ANIMATION_STATE.WALKING):
		player_animated_sprite.animation = "walking"
	if (animation_state == ANIMATION_STATE.JUMPING):
		player_animated_sprite.animation = "jumping"
	if (animation_state == ANIMATION_STATE.FALLING):
		player_animated_sprite.animation = "falling"

	player_animated_sprite.play()
	
	
	var hands_items_sprite: Sprite2D = get_node("HandsItemsSprite2D")
#	hands_items_sprite.position = cursor_sprite.position
	hands_items_sprite.position.y = 35 + player_animated_sprite.frame
	
	if (self.global_position.x >= cursor_sprite.global_position.x):
		hands_items_sprite.flip_h = false
		player_animated_sprite.flip_h = false		
	else:
		hands_items_sprite.flip_h = true
		player_animated_sprite.flip_h = true
	
	if (direction.x > 0):
		player_animated_sprite.flip_h = true
	if (direction.x < 0):
		player_animated_sprite.flip_h = false
	
	print("P pos: ", self.position.x+20, " ", self.position.y+20)
	print("C pos: ", cursor_sprite.position)
	
	if (0 <= cursor_sprite.position.x and cursor_sprite.position.x <= 70) and (0 <= cursor_sprite.position.y and cursor_sprite.position.y <= 80):
		hands_items_sprite.position.y = 35 + player_animated_sprite.frame
		hands_items_sprite.rotation_degrees = 0
		if (cursor_sprite.position.x >= 30):
			if (direction.x != 0):
				match direction.x:
					-1:
						hands_items_sprite.flip_h = true
					1:
						hands_items_sprite.flip_h = false
			else:
				hands_items_sprite.flip_h = true
			if (direction.x == 0):
				player_animated_sprite.flip_h = true		
		else:
			hands_items_sprite.flip_h = false
			if (direction.x == 0):
				player_animated_sprite.flip_h = false
	else:
		hands_items_sprite.look_at(cursor_sprite.global_position)
		if (hands_items_sprite.flip_h == false):
			hands_items_sprite.rotation_degrees += 180
#	var r = hands_items_sprite.rotation_degrees
#	print("r: ", r)
#	print("cursor.global_position: ", cursor_sprite.global_position)
#	print("player.global_position: ", self.global_position)
#
	
#	if (90 <= r and r <= 270):
#		hands_items_sprite.flip_h = true
#	else:
#		hands_items_sprite.flip_h = false
#
#	var direction: Vector2 = cursor_sprite.position - self.position
#	var angle: float = direction.angle_to(Vector2.RIGHT)
#	hands_items_sprite.rotation = angle
	
#	hands_items_sprite.look_at(cursor_sprite.position)
#	hands_items_sprite.position = player_animated_sprite.position + cursor_sprite.position
	

func get_input_direction_x() -> int:
	var axis_data: Dictionary = get_gamepad_axis_data()
	var input_direction: int = 0
	var keyboard_or_dpad_pressed: bool = false
	if (axis_data["DATA"] == null):
		input_direction = Input.get_axis("left","right")
	else:
		if (Input.get_axis("left","right") != 0):
			keyboard_or_dpad_pressed = true
		if (not keyboard_or_dpad_pressed):
			var axis_vector: Vector2 = axis_data["DATA"]["JOY_AXIS_LEFT_STRENGTH"]
			if (0.6 >= float(axis_vector[0]) and float(axis_vector[0]) >= -0.6):
				input_direction = 0
			if (float(axis_vector[0]) > 0.6):
				input_direction = 1
			if (float(axis_vector[0]) < -0.6):
				input_direction = -1
		else:
			input_direction = Input.get_axis("left","right")
	return input_direction
	
func get_input_direction_y() -> int:
	var axis_data: Dictionary = get_gamepad_axis_data()
	var input_direction: int = 0
	var keyboard_or_dpad_pressed: bool = false
	
	
	if (axis_data["DATA"] == null):
		input_direction = Input.get_axis("up","down")
	else:
		if (Input.get_axis("up","down") != 0):
			keyboard_or_dpad_pressed = true
		if (not keyboard_or_dpad_pressed):
			var axis_vector: Vector2 = axis_data["DATA"]["JOY_AXIS_LEFT_STRENGTH"]
			if (0.6 >= float(axis_vector[1]) and float(axis_vector[1]) >= -0.6):
				input_direction = 0
			if (float(axis_vector[1]) > 0.6):
				input_direction = 1
			if (float(axis_vector[1]) < -0.6):
				input_direction = -1
		else:
			input_direction = Input.get_axis("left","right")
	
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
		
	
	if is_on_floor():
		if (direction.x == 0):
			animation_state = ANIMATION_STATE.IDLE
		else:
			animation_state = ANIMATION_STATE.WALKING
	else:
		animation_state = ANIMATION_STATE.FALLING
	
	if (Input.get_action_strength("run")):
		velocity.x = speed.x * 1.4 * direction.x
		$PlayerAnimatedSprite2D.speed_scale = 1.4
	else:
		velocity.x = speed.x * direction.x
		$PlayerAnimatedSprite2D.speed_scale = 1

#	move_local_x(direction.x * speed.x, true)

	update_cursor()
	
	levatation_spell()


	for bullet in bullets_array:
		bullet.move_and_slide()

	if (IS_PAUSED == false):
		move_and_slide(); move_and_slide()
		animate()
	
#	if (player_status_vertical == PlayerState.PLAYER_IN_AIR) or (player_status_vertical == PlayerState.PLAYER_ON_LADDER): 
#		if (player_status_vertical == PlayerState.PLAYER_IN_AIR):
#			direction.y = 1; speed.y = 0.8
#		move_local_y(direction.y * speed.y, true)
#
#	collisions_positions.clear()
#	collisions_types.clear()


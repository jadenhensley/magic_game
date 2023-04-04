extends Node2D

class_name JumpComponent

# TODO:
# - coyote jump
# - released jump (only go so high as the duration of the press/release)
# - less floaty jump ?
# - less heavy jump ?
# - make jump more comfortable to player


@export var jump_parameters: JumpParameters
@export var parent_node: Entity


@onready var jump_height: float = jump_parameters.jump_height
@onready var time_to_peak: float = jump_parameters.time_to_peak
@onready var time_to_descent: float = jump_parameters.time_to_descent

enum JumpState {
	JUMP_NOT_STARTED,
	JUMP_STARTED,
	JUMP_STOPPED,
	JUMP_NOT_RELEASED,
	JUMP_RELEASED
}

@onready var jump_started: bool = false
@onready var jump_released: bool = false
@onready var jump_peak: float = 0.0
@onready var jump_peak_reached: bool = false
@onready var jump_stopped: bool = false
@onready var jump_origin_y: float = 0.0
@onready var jump_origin_made: bool = false

@onready var vy: float = 0.0 # a separate velocity y from the parent_node's velocity y. 
# exists to add parent_node.gravity and vy to parent_ndoe.velocity.y
# may use this in future. for now I decided not to use it because of a bug.

# Called when the node enters the scene tree for the first time.
func _ready():
	if (jump_parameters == null):
		print("[In JumpComponent] No JumpParametersResource was provided.")
	if (parent_node == null):
		print("[In JumpComponent] No Parent Node was provided. (Entity or Player that extends Entity)")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (parent_node.IS_PLAYER):
		if (Input.is_action_just_pressed("up")):
			jump_started = true
		if (Input.is_action_just_released("up")):
			jump_released = true

		if (parent_node.player_status_vertical == parent_node.PlayerState.PLAYER_IN_AIR):
			if (not jump_started):
				parent_node.velocity.y = parent_node.gravity
				parent_node.direction.y = 1
		if (parent_node.player_status_vertical == parent_node.PlayerState.PLAYER_TOUCHED_GROUND):
			parent_node.velocity.y = 0
			parent_node.direction.y = 0
			jump_started = false
			jump_released = false
			jump_stopped = true
			jump_peak_reached = false
			jump_origin_made = false
			parent_node.player_status_vertical = parent_node.PlayerState.PLAYER_ON_GROUND
		
		if (parent_node.DEBUG):
			match (parent_node.player_status_vertical):
				parent_node.PlayerState.PLAYER_ON_GROUND:
					print("[PLAYER_ON_GROUND]")
		
#			print("JUMP STARTED")
		if (jump_started):
			parent_node.direction.y = -1
			if (not jump_origin_made):
				jump_origin_y = parent_node.position.y
				jump_peak = jump_origin_y - jump_height
				jump_origin_made = true
			else:
				if (not jump_peak_reached):
					parent_node.player_status_vertical = parent_node.PlayerState.PLAYER_JUMPING
					parent_node.velocity.y -= time_to_peak
					if (parent_node.position.y < jump_peak):
						jump_peak_reached = true
				else:
					parent_node.velocity.y += time_to_descent
					
	parent_node.move_and_slide()

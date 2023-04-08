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
# placeholder variables
# old code removed because it was buggy.
@onready var jump_released_recognized: bool = false
@onready var jump_peak: float = 0.0
@onready var jump_peak_reached: bool = false
@onready var jump_stopped: bool = false
@onready var jump_origin_y: float = 0.0
@onready var jump_origin_made: bool = false
@onready var raycast_below_colliding: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	if (jump_parameters == null):
		print("[In JumpComponent] No JumpParametersResource was provided.")
	if (parent_node == null):
		print("[In JumpComponent] No Parent Node was provided. (Entity or Player that extends Entity)")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if (parent_node.IS_PLAYER):
		if (Input.is_action_just_pressed("up")):
			jump_started = true
			jump_released = false
			print("jump started")
		if (Input.is_action_just_released("up")):
			jump_started = false
			jump_released = true
			print("jump released")
		
		parent_node.velocity.y += parent_node.gravity
		if (jump_started) and (parent_node.is_on_floor()):
			parent_node.velocity.y = -parent_node.jump_strength
		if (jump_released):
			parent_node.velocity.y = parent_node.jump_strength / 2
					

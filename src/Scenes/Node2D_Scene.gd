extends Node2D

@onready var scene_transition_startofgame_node: SceneTransition = $SceneTransitionFade
@onready var player: Player = $Player
@onready var intro_text_label = $CanvasLayerIntroText/LabelIntroText


# Called when the node enters the scene tree for the first time.
func _ready():
	intro_text_label.visible = false	
	player.IS_PAUSED = true
	await scene_transition_startofgame_node.play_animation("dissolve")
	intro_text_label.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#	if (intro_text_label.visible == true):
#		await scene_transition_startofgame_node.play_animation("reversed")
#		intro_text_label.visible = false
#

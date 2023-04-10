extends Node2D

@onready var scene_transition_startofgame_node: SceneTransition = $SceneTransitionFade
@onready var player: Player = $Player
@onready var intro_text_label = $CanvasLayerIntroText/LabelIntroText
@onready var intro_text_timer: Timer = Timer.new()
@onready var intro_text_timer_started: bool = false
@onready var start_game_button: Button = $CanvasLayerIntroText/StartGameButton
@onready var start_game_button_pressable: bool = false
@onready var start_game_button_pressed_once: bool = false
@onready var intro_done: bool = false
@onready var fps_label: Label = $Player/Camera2D/LabelFPS
@onready var fps_label_text: String = "FPS: %d"


# Called when the node enters the scene tree for the first time.
func _ready():
	intro_text_label.visible = false	
	start_game_button.visible = false
	player.IS_PAUSED = true
	fps_label.visible = false # make true if you need to debug framerate
	await scene_transition_startofgame_node.play_animation("dissolve")
	intro_text_label.visible = true
	intro_text_timer.wait_time = 10.0
	intro_text_timer.autostart = true
	start_game_button.pressed.connect(self._start_game_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (intro_text_label.visible == true):
		if (not intro_done):
			if (not intro_text_timer_started):
				intro_text_timer.start()
				intro_text_timer_started = true
			if (intro_text_timer_started and intro_text_timer.get_time_left() == 0):
				await scene_transition_startofgame_node.play_animation("wait_for_intro")
				start_game_button.visible = true
				start_game_button_pressable = true
	if (not player.IS_PAUSED):
		fps_label.text = fps_label_text % Engine.get_frames_per_second()
	else:
		fps_label.text = "PAUSED"
		
func _start_game_button_pressed():
	if (start_game_button_pressable):
		scene_transition_startofgame_node.play_animation("reversed")
		intro_text_label.visible = false
		start_game_button_pressed_once = true
		start_game_button.visible = false
		start_game_button_pressable = false
		intro_done = true
		player.IS_PAUSED = false

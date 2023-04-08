extends CanvasLayer

class_name SceneTransition

@export var scene_transition_resource: SceneTransitionResource

@onready var recognized_animations: Array = ["RESET", "dissolve"]

@onready var recognized_scenes: Dictionary = {
	"default_level":"res://src/Scenes/Level Scenes/default_level.tscn",
}


func play_animation(animation: String) -> void:
	if (animation in recognized_animations):
		match animation:
			"dissolve":
				$AnimationPlayer.play(animation)
				await $AnimationPlayer.animation_finished
			"reversed":
				$AnimationPlayer.play_backwards(animation)
				await $AnimationPlayer.animation_started
			_:
				$AnimationPlayer.play(animation)
				await $AnimationPlayer.animation_finished
	
func get_scene_filepath_from_scene_name(scene_name: String) -> String:
	if (scene_name in recognized_scenes):
		return recognized_scenes[scene_name]
	else:
		return ""
		

func change_to_scene(scene: String) -> bool:
	if (scene_transition_resource.change_scene):
		var scene_filepath = get_scene_filepath_from_scene_name(scene_transition_resource.target_scene_name)
		if (scene_filepath != ""):
			get_tree().change_scene_to_file(scene_filepath)
			return true
		else:
			return false
	else:
		return false

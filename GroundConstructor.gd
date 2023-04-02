extends Node2D

const GROUND_TILE_SIZE := 48

func spawn_ground_tile(x: int, y: int) -> void:
	var groundtile_scene = load("ground_scene.tscn")
	var groundtile = groundtile_scene.instantiate()
	
	var color_rect = groundtile.get_node("ColorRect")
	color_rect.color = Color(
		float(139+randi_range(0,20))/255,
		float(69+randi_range(0,20))/255,
		float(19+randi_range(0,20))/255
	)
	
	groundtile.position = Vector2i(x, y)
	
	add_child(groundtile)

# Called when the node enters the scene tree for the first time.
func _ready():
	for iy in range(12):
		for ix in range(50):
			spawn_ground_tile(ix*GROUND_TILE_SIZE,400+iy*GROUND_TILE_SIZE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

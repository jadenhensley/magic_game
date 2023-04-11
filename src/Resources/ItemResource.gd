extends Resource

class_name Item

const RECOGNIZED_ITEM_ID_ARRAY: Array = [
	"ITEM_TOOL_SWORD",
	"ITEM_TOOL_PICKAXE",
	"ITEM_TOOL_AXE",
	"ITEM_TOOL_GUN",
	"ITEM_POTION_REGEN_HEALTH",
	"ITEM_MUSHROOM",
	"ITEM_WOOD",
	"ITEM_STICK",
	"ITEM_LEAF",
	"ITEM_MONSTERPART_WING",
	"ITEM_MONSTERPART_SKELETON",
	"ITEM_MONSTERPART_GUTS",
	"ITEM_MONSTERPART_MEAT",
	"ITEM_MONSTERPART_HORNS"
]

@export var item_id: String
@export var item_name: String
@export var item_sprite: Sprite2D

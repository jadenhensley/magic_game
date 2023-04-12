extends Panel

#@onready var ITEM_ID = ItemIDLookup.ITEM_ID

@export var item: Item

func _ready():
	if (item != null):
		assert (item in Item.RECOGNIZED_ITEM_ID_ARRAY)
	

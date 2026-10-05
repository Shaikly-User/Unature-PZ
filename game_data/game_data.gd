extends Node

var tooltip: Object
var items: Dictionary

func _ready() -> void:
	loading_resources("res://game_data/game_main/")

func loading_resources(path: String) -> void:
	var _temp_items = load(path + "items.json").data
	for _name in _temp_items.keys():
		var _item := Item.new()
		_item.name = _name
		_item.texture = load(path + "items_texture/" + _temp_items[_name].get("texture","default.svg"))
		_item.content = _temp_items[_name].get("content","")
		_item.tags = _temp_items[_name].get("tags",{})
		items[_name] = _item
	#tooltip = load(path+"textures/game_ui_tooltip.tscn")

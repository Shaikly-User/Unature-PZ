class_name GameMain extends Node2D

const CARDS_CHOOSER := preload("uid://cga7oaqggfwq8")

var game_resource := Data.new()

@onready var viewport_size := get_viewport().get_visible_rect().size
@onready var cards_bar: TextureRect = $UI/CardsBar
var ground_transform:Transform2D = Transform2D(Vector2(100,0),Vector2(0,80),Vector2(300,160))
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prepare()
	begin()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func prepare() -> void:
	pass

func begin() -> void:
	var right_side :float = viewport_size.x-$Ground/Background.texture.get_width()*1.08
	var tween := create_tween().set_trans(Tween.TRANS_QUAD)
	tween.tween_property($Ground, "position:x", 0, 2.0)
	await tween.tween_property($Ground, "position:x", right_side, 3.0).finished
	await choose_card()
	print("cards ready:",game_resource.cards)
	tween = create_tween().set_trans(Tween.TRANS_QUAD)
	tween.tween_property($Ground, "position:x", 0.0, 1.0)
	tween.tween_property($UI/CardsBar, "position:y", 0.0, 1.0)

func choose_card() -> void:
	var cards_chooser := CARDS_CHOOSER.instantiate()
	cards_chooser.storage_items = GameData.items
	$UI.add_child(cards_chooser)
	game_resource.cards = await cards_chooser.backpack_ready
	cards_chooser.card_use_requested.connect(using_card)

func using_card(card: Card):
	$UI/HandheldItem.process_mode = Node.PROCESS_MODE_INHERIT
	$UI/HandheldItem.texture = card.item.texture
	await $UI/HandheldItem.pressed
	using_tag(card.item.tags.keys()[0],card.item.tags.values()[0])
	$UI/HandheldItem.texture = null
	$UI/HandheldItem.process_mode = Node.PROCESS_MODE_DISABLED
	pass

func using_tag(tag: StringName, args: Dictionary):
	match tag:
		&"plant":
			var _plant:Plant = load(args.get("uid")).instantiate()
			_plant.ground_position = Vector3(get_local_mouse_position().x,get_local_mouse_position().y,0)
			$Ground.add_child(_plant)

class Data extends Resource:
	var cards: Array
	var sprites: Array

extends Control

signal card_use_requested(card)

const CARD = preload("uid://mtdat5sj63vm")

enum STATE{
	NONE,
	DISABLED,
	IN_CHOOSE,##选卡时
	IN_GAME,##游戏内
}

var storage_items:Dictionary
var onready_items:Array[Item]

var _state := STATE.DISABLED
signal backpack_ready(onready_cards:Array)

@onready var viewport_size := get_viewport().get_visible_rect().size

func _ready() -> void:
	storage_switch()
	state_switch(STATE.IN_CHOOSE)
	await $Storage/QuitButton.pressed
	await state_switch(STATE.IN_GAME)
	backpack_ready.emit(onready_items)

##搜索包含指定标签的卡牌（未完工）
func storage_switch(label:String=""):
	for child in $Storage/Cards.get_children():
		child.queue_free()
	var visible_cards := storage_items
	for key in visible_cards.keys():
		var card := CARD.instantiate()
		card.item = storage_items[key]
		card.content = storage_items[key].content
		card.choosed.connect(_storage_cards_toggled.bind(card))
		$Storage/Cards.add_child(card)

##切换选卡框的显示，并播放动画
func state_switch(final_state:STATE) -> void:
	if final_state != _state:
		_state=STATE.DISABLED
		var tween := create_tween().set_trans(Tween.TRANS_QUAD)
		$Storage.process_mode = Node.PROCESS_MODE_INHERIT if final_state==STATE.IN_CHOOSE else Node.PROCESS_MODE_DISABLED
		tween.tween_property($CardsBar, "position:y", 0.0 if final_state in [STATE.IN_CHOOSE,STATE.IN_GAME] else -96.0, 1.0)
		await tween.parallel().tween_property($Storage, "position:y", viewport_size.y-($Storage.size.y if final_state==STATE.IN_CHOOSE else 0.0), 1.0).finished
		_state = final_state

func _storage_cards_toggled(card: Node) -> void:
	var onready: bool = onready_items.any(func(item):return item.name == card.item.name)
	if not onready:
		var card_node := CARD.instantiate()
		card_node.item = card.item
		card_node.quantity = 1
		card_node.choosed.connect(_onready_cards_toggled.bind(card_node))
		card_node.depleted.connect(_onready_cards_depleted.bind(card_node))
		$CardsBar/Cards.add_child(card_node)
		onready_items.append(card.item)
		pass
	if onready:
		var card_id := onready_items.find(card.item)
		await $CardsBar/Cards.get_child(card_id).flip(1)
		$CardsBar/Cards.get_child(card_id).use()
		onready_items.remove_at(card_id)
		get_node("Storage/Cards/"+card.item.name).flip(0)
		pass

func _onready_cards_toggled(card: Node) -> void:
	match _state:
		STATE.IN_CHOOSE:
			var card_id := onready_items.find(card.item)
			onready_items.remove_at(card_id)
			get_node("Storage/Cards/"+card.item.name).flip(0)
		STATE.IN_GAME:
			card_use_requested.emit(card)
func _onready_cards_depleted(card: Node) -> void:
	match _state:
		STATE.IN_CHOOSE:
			card.queue_free()


func _quit_button_down() -> void:
	$Storage/QuitButton.position+=Vector2.ONE
	await $Storage/QuitButton.button_up
	$Storage/QuitButton.position-=Vector2.ONE
	pass # Replace with function body.


func _on_lawn_pressed() -> void:
	pass # Replace with function body.

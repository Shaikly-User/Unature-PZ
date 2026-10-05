class_name Card extends TextureButton

signal choosed()
signal depleted()

var quantity:int=-1

var item: Item:
	set(value):
		item = value
		name = item.name
		$Texture.texture = item.texture
		content = item.content
var content: Dictionary:
	set(value):
		content = value
		texture_normal.region.position.x = 50 * content.get("card",0.0)#card_back_set
		$Front/Label.text = str(content.get("cost",""))

func _ready() -> void:
	$AnimationPlayer.play("flip")

func _on_toggled(toggled_on: bool) -> void:
	await flip(toggled_on)
	choosed.emit()
	use()


func flip(side:bool) -> void:
	set_pressed_no_signal(side)
	$Front.visible = not side
	$AnimationPlayer.play("flip")
	await $AnimationPlayer.animation_finished

func use():
	quantity -= 1
	if quantity == 0:
		disabled = true
		depleted.emit()

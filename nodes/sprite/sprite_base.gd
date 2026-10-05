class_name SpriteBase extends Node2D

@export var ground_position:Vector3 :
	set(value):
		ground_position = value
		position = Vector2(value.x,value.y + value.z)
@export var health_point := 300:
	set(value):
		health_point = value
		if value == 0: dying()

var _shadow := Sprite2D.new()

func _ready() -> void:
	ground_position = ground_position
	_shadow.texture = load("uid://ugmqxy1im0m6")
	_shadow.scale = Vector2(1.0,0.8)
	add_child(_shadow)
	move_child(_shadow, 0)
	pass # Replace with function body.



func _process(delta: float) -> void:
	pass


func dying():
	queue_free()

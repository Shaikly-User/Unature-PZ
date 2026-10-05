class_name SpriteBase extends Node2D

@export var ground_position:Vector3 :
	set(value):
		ground_position = value
		position = Vector2(value.x,value.y + value.z)
@export var health_point := 300:
	set(value):
		health_point = value
		if value == 0: dying()

func _ready() -> void:
	ground_position = ground_position
	pass # Replace with function body.



func _process(delta: float) -> void:
	pass

func dying():
	queue_free()

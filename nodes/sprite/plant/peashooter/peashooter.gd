extends Plant

@onready var _anim_tree: AnimationTree = $View/AnimTree

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_anim_tree["parameters/BlinkShot/request"] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
	while 0:
		await get_tree().create_timer(3).timeout
		_anim_tree["parameters/Shoot/request"] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

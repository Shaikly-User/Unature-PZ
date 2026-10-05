extends GraphEdit

@onready var popup_menu: PopupMenu = $PopupMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_RIGHT and event.pressed:
			popup_menu.popup()

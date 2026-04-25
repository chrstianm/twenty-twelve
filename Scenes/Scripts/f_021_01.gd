extends Control
func _ready() -> void:
	CursorManager.set_normal()


func _on_forward_mouse_entered() -> void:
	pass # Replace with function body.
	CursorManager.set_hover()

func _on_forward_mouse_exited() -> void:
	pass # Replace with function body.
	CursorManager.set_normal()

func _on_forward_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
	if event is InputEventMouseButton:
			if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
				AudioManager.play_sfx("click")
				await get_tree().create_timer(0.3).timeout
				get_tree().change_scene_to_file("res://Scenes/Game/f_022_01.tscn")

func _on_back_mouse_entered() -> void:
	pass # Replace with function body.
	CursorManager.set_back()

func _on_back_mouse_exited() -> void:
	pass # Replace with function body.
	CursorManager.set_normal()

func _on_back_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
	pass # Replace with function body.
	if event is InputEventMouseButton:
			if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
				AudioManager.play_sfx("click")
				get_tree().change_scene_to_file("res://Scenes/Game/f_020_01.tscn")

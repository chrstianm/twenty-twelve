extends Control

@onready var redact: ColorRect = $redact
@onready var text: Label = $text

var psst_loop := true


func _on_back_mouse_entered() -> void:
	CursorManager.set_back()


func _on_back_mouse_exited() -> void:
	CursorManager.set_normal()


func _on_back_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			AudioManager.play_sfx("click")
			get_tree().change_scene_to_file("res://Scenes/Game/c_005_01.tscn")


func _ready() -> void:
	CursorManager.set_normal()
	if GlobalManager.bush_sound == 0:
		loop_psst()
		GlobalManager.bush_sound += 1
	
	if GlobalManager.is_picture_picked_up == true:
		redact.show()


func loop_psst() -> void:
	while psst_loop:
		AudioManager.play_sfx("psst")
		await get_tree().create_timer(10.0).timeout


func _on_entity_mouse_entered() -> void:
	pass


func _on_entity_mouse_exited() -> void:
	pass


func _on_entity_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			
			# Stop the loop
			psst_loop = false
			
			if GlobalManager.is_picture_picked_up == false:
				AudioManager.play_sfx("click")
				text.show()
				redact.show()
				
				await get_tree().create_timer(3.5).timeout
				
				text.hide()
				GlobalManager.is_picture_picked_up = true

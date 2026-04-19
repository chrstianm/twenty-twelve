extends Control

func _ready() -> void:
	await get_tree().create_timer(5.0).timeout
	get_tree().change_scene_to_file("res://Scenes/Game/F001_01.tscn")

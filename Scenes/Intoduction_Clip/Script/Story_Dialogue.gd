extends Label

# Reference to the TextureRect node
@onready var entity_display = $"../TextureRect"
@onready var sub_viewport_container: SubViewportContainer = $"../.."

# The Library: Text and optional image path
var archive_data = [
	{
		"text": "wear earphones for best experience.",
		"image": "res://Assets/Pictures/Victim3_3_-removebg-preview.png"
	},
	{
		"text": "DATA RECOVERY: [CASE_FILE_99-B]\nSubject: Colt Ga████n (Missing since 04/07/2012)\n\nEntry No. 012-23\n\nThe library lights flickered at 7:00 PM, but they never came back on. \nI tried the main lobby doors, but the handles won't even budge. \nIt’s like they’re part of the wall now.",
		"image": null 
	},
	{
		"text": "DATA RECOVERY: [CASE_FILE_104-A]\nSubject: Unknown (Recovered Journal)\n\nEntry No. 088-04: \n\nThe stairs don't go down anymore. \nI went down three flights and ended up on the roof. \nI looked out, but there’s no one outside. \nJust a black void where the horizon should be. \n\n7:13 PM. It’s always 7:13 PM.",
		"image": null 
	},
		{
		"text": "DATA RECOVERY: [CASE_FILE_104-A]\nSubject: Unknown (Recovered Journal)\n\nEntry No. 088-04:\n████████h ████████\n████████████████████ e████████████████████████████████████\n████████l ███████████████████ p ████████\n████████████████████us████████████████████████████████████████████████\n████████████████████████████████████████████████\n",
		"image": "res://Assets/Pictures/Victim3_3_-removebg-preview.png"
	},
]

var current_index = 0
@onready var timer = Timer.new()

func _ready():
	await get_tree().create_timer(2.5).timeout
	# Start with a clean slate
	text = ""
	visible_ratio = 1.0 # Ensure text is always fully visible
	entity_display.texture = null
	
	# Setup the loop timer
	add_child(timer)
	timer.wait_time = 3.0
	timer.timeout.connect(display_next_entry)
	
	# Show the first entry immediately on start
	display_next_entry()
	timer.start()

func display_next_entry():
	# 1. Peek at the data for the current index
	if current_index < archive_data.size():
		var data = archive_data[current_index]
		
		text = data["text"]
		# --- IMAGE LOGIC (Instant) ---
		if data["image"] != null:
			entity_display.texture = load(data["image"])
			entity_display.modulate.a = 1.0
		else:
			# If the data has NO image, clear the display
			entity_display.texture = null
		
		AudioManager.play_sfx("type")
		await get_tree().create_timer(2.0).timeout
		text = ""
		current_index += 1
	else:
		# Reset the index to loop the archive from the start
		current_index = 0 
		display_next_entry()
	
	if current_index == 3:
		AudioManager.play_sfx("static_for_intro")
		await get_tree().create_timer(6.5).timeout
		get_tree().change_scene_to_file("res://Scenes/Intoduction_Clip/Archive.tscn")

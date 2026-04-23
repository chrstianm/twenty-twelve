extends Node

# Dictionary to keep track of currently playing BGM players
# Key: track_name (String), Value: AudioStreamPlayer2D instance
var active_bgm_players = {}

var music_tracks = {
	"static": preload("res://Assets/Audio/radio_static_2.MP3"),
	"glitch": preload("res://Assets/Audio/glitch_static(1).MP3"),
	"outside": preload("res://Assets/Audio/OutsideBGM.MP3"),
	"vhs_static": preload("res://Assets/Audio/vhs_static.mp3"),
	"ambiance_extreme": preload("res://Assets/Audio/ambiance_extreme(1).MP3")
}

var sfx_sounds = {
	"type": preload("res://Assets/Audio/keyboard_click.MP3"),
	"whispers": preload("res://Assets/Audio/Sighting_Sound(1).MP3"),
	"click" : preload("res://Assets/Audio/mouse_click.mp3"),
	"ill_find_you": preload("res://Assets/Audio/ill_find_you(1).MP3"),
	"bush": preload("res://Assets/Audio/bush_sounds.MP3"),
	"subtle_bush": preload("res://Assets/Audio/subtle_bush.MP3"),
	"psst": preload("res://Assets/Audio/psst.MP3"),
	"hey": preload("res://Assets/Audio/hey.MP3"),
	"rattle": preload("res://Assets/Audio/rattle_jumpscare.MP3"),
	"static_for_intro": preload("res://Assets/Audio/static_for_intro.mp3"),
	"heavy_breath": preload("res://Assets/Audio/heavy_breaths(1).MP3")
}

func play_bgm(track_name: String) -> void:
	if not music_tracks.has(track_name):
		push_error("AudioManager: Music track not found -> " + track_name)
		return
	
	# If this specific track is already playing, don't start it again
	if active_bgm_players.has(track_name):
		return
		
	var music_stream = music_tracks[track_name]
	
	# Handle looping
	if music_stream is AudioStreamMP3:
		music_stream.loop = true
	elif music_stream is AudioStreamWAV:
		music_stream.loop_mode = AudioStreamWAV.LOOP_FORWARD
	
	# Create a new player for this specific track
	var new_player = AudioStreamPlayer2D.new()
	new_player.stream = music_stream
	add_child(new_player)
	new_player.play()
	
	# Store the player in the dictionary so we can reference it later
	active_bgm_players[track_name] = new_player

# Stop a specific track
func stop_bgm(track_name: String) -> void:
	if active_bgm_players.has(track_name):
		var player = active_bgm_players[track_name]
		player.stop()
		player.queue_free()
		active_bgm_players.erase(track_name)

# Stop all music (useful for scene transitions)
func stop_all_bgm() -> void:
	for track_name in active_bgm_players.keys():
		stop_bgm(track_name)
	
func play_sfx(sound_name: String) -> void:
	if not sfx_sounds.has(sound_name):
		push_error("AudioManager: SFX not found -> " + sound_name)
		return
		
	var sfx_player = AudioStreamPlayer.new()
	sfx_player.stream = sfx_sounds[sound_name]
	
	add_child(sfx_player)
	sfx_player.play()
	sfx_player.finished.connect(sfx_player.queue_free)

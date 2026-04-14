extends Control

var audio_bus

func _ready() -> void:
	get_tree().paused = true
	audio_bus = AudioServer.get_bus_index("Music")

func _on_fullscreen_toggle_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_audio_control_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(audio_bus, value)

func _on_quit_options_pressed() -> void:
	get_tree().paused = false
	queue_free()

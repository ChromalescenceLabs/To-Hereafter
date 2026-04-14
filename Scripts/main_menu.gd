extends Control

var options_scene : PackedScene = preload("uid://bfxdad2vmpkx")

var width
var height

func _ready() -> void:
	width = get_viewport_rect().size.x
	height = get_viewport_rect().size.y

func _on_begin_pressed() -> void:
	SceneLoader.load_scene("uid://bbxwnl4ctuot6", 1.5)
	var tween = create_tween().tween_property(Music, "volume_db", -90.0, 3)
	await tween.finished

func _on_options_pressed() -> void:
	var options = options_scene.instantiate()
	options.position = Vector2(width/2, height/2)
	add_child(options)

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_load_pressed() -> void:
	pass # Add Load Functionality

func _on_save_pressed() -> void:
	pass # Add Save Functionality

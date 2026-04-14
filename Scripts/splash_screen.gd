extends Node2D

@onready var CLLogo = $CL_Logo
@onready var CLText = $CL_Text
var width
var height

func _ready() -> void:
	Music.play()
	width = get_viewport_rect().size.x
	height = get_viewport_rect().size.y
	CLText.modulate.a = 0
	CLLogo.modulate.a = 1
	
	CLLogo.position = Vector2(width/2, height/2)
	CLText.position = Vector2(width/2, height/2)

	var LogoFadeOut = create_tween().tween_property(CLLogo, "modulate:a", 0, 2.7).set_delay(2).set_ease(Tween.EASE_IN_OUT)
	await LogoFadeOut.finished
	
	var TextFadeIn = create_tween().tween_property(CLText, "modulate:a", 1, 3).set_ease(Tween.EASE_IN_OUT)
	await TextFadeIn.finished
	
	var TextFadeOut = create_tween().tween_property(CLText, "modulate:a", 0, 2.6).set_delay(2).set_ease(Tween.EASE_IN_OUT)
	await TextFadeOut.finished
	
	SceneLoader.load_scene("uid://cvp7sk28csjfr", 0)

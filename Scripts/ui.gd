extends CanvasLayer

var form = "none"

func _process(_delta):
	if Input.is_action_just_pressed("transformation"):
		$SelectionWheel.show()
		Engine.time_scale = 0.1
		get_parent().get_parent().velocity.y = 0
		get_viewport().warp_mouse(get_viewport().get_visible_rect().size / 2)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif Input.is_action_just_released("transformation"):	
		@warning_ignore("shadowed_variable_base_class")
		var transform = $SelectionWheel.Close()
		form = transform
		$Label.text = "Player Transformation: " + transform
		Engine.time_scale = 1
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

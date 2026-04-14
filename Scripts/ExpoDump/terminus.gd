extends Sprite2D

func _ready() -> void:
	self.modulate.a = 0
	
func beVisible():
	var tween = create_tween().tween_property(self, "modulate:a", 1, 1).set_ease(Tween.EASE_IN_OUT)
	
	return tween

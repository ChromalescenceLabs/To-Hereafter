extends TextureButton

var time = 0.0
var frequency = randf_range(-3, 3)
var width
var height
var viewport

func _ready() -> void:
	viewport = get_viewport_rect().size
	
	self.modulate.a = 0	
	self.disabled = true

func _process(delta: float) -> void:
	time += delta

	rotation_degrees = sin(time * frequency) * -1.3
	position.x += cos(time * frequency * 2) * 10 * delta 
		
func beVisible() -> void:
	create_tween().tween_property(self, "modulate:a", 1, 1).set_ease(Tween.EASE_IN_OUT)
	self.disabled = false

func beInvisible():
	var tween = create_tween().tween_property(self, "modulate:a", 0, 1).set_ease(Tween.EASE_IN_OUT)
	self.disabled = true
	
	return tween

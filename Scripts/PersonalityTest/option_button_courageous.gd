extends TextureButton

var q_num
var root_node

@onready var A1 = $Q1
@onready var A2 = $Q2
@onready var A3 = $Q3
@onready var A4 = $Q4
@onready var A5 = $Q5
@onready var answers = [A1, A2, A3, A4, A5]

func _ready() -> void:
	answers[q_num].visible = true
	root_node = self.get_parent().get_parent()
	pass

func _on_pressed() -> void:
	root_node.questions[q_num].visible = false
	root_node.q_num += 1
	root_node.cour_num += 1
	for i in self.get_parent().get_children():
		if i is TextureButton:
			i.queue_free()
		else:
			pass

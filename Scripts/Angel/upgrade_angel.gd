extends Sprite2D

@export var interactable: Area2D

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	print("opened upgrades menu")
	

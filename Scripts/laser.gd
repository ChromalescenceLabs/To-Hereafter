@tool

extends RayCast2D

@export var castSpeed := 7000.0
@export var maxLength := 1400.0

@export var isCasting := false: set = setIsCasting

@export var colour :=Color.WHITE: set = setColour

@onready var laserLine: Line2D = $Line2D
@onready var laserWidth := laserLine.width

@export var growthTime :=.1
var tween:Tween = null

func _ready() -> void:
	setColour(colour)
	setIsCasting(isCasting)

func _physics_process(delta: float):
	target_position.x = move_toward(
		target_position.x,
		maxLength,
		castSpeed * delta
	)
	
	var laserEndPos := target_position
	force_raycast_update()
	if is_colliding():
		laserEndPos = to_local(get_collision_point())
	laserLine.points[1] = laserEndPos

func setIsCasting(newValue: bool):
	if isCasting == newValue:
		return
	isCasting=newValue
	set_physics_process(isCasting)
	
	if not laserLine:
		return
	
	if isCasting == false:
		target_position.x = 0.0
		disappear()
	else:
		appear()
		
func appear():
	laserLine.visible = true
	tween = create_tween()
	tween.tween_property(laserLine, "width", laserWidth, growthTime* 2.0).from(0.0)

func disappear():
	if tween and tween.is_running():
		tween.kill()
	tween= create_tween()
	tween.tween_property(laserLine, "width", 0.0, growthTime).from_current()
	tween.tween_callback(laserLine.hide)

func setColour (NewColour:Color):
	colour = NewColour
	if laserLine == null:
		return
	laserLine.modulate = NewColour

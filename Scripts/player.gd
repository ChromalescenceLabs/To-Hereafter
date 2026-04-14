extends CharacterBody2D
class_name Player

const fireball = preload("res://Scenes/fireball.tscn")
var canShoot = true

@onready var laser = $Animations/MothFormAnims/laser
var shootNum = 0

@onready var CoyoteTimer = $CoyoteTimer
@onready var JumpBufferTimer = $JumpBufferTimer

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

@export var speed = 20.0
@export var jump_height : float = 40.0
@export var jump_time_to_peak : float = 0.25
@export var jump_time_to_descent : float = 0.19

@export var dash_speed = 50.0
var dashing = false
var can_dash = true

@export var speed_multipilier = 30
var direction = 0

const FLAP_SPEED : int = 400

var canAbilityH = true

func _physics_process(delta):
	#👻REGULAR FORM
	if $"Radial Menu/UI".form == "None" or $"Radial Menu/UI".form == "none":
		for i in $Animations.get_children():
			if i.name == "NormalFormAnims":
				i.visible = true
			else:
				i.visible = false
		
		speed = 10
		velocity.y += gravityget() * delta

		# Handle jump.
		if Input.is_action_just_pressed("jump"):
			JumpBufferTimer.start()
			
		if Input.is_action_just_pressed("dash") and can_dash:
			dashing = true
			can_dash = false
			$DashTimer.start()
			$DashCooldown.start()
			
		if	(is_on_floor() or not CoyoteTimer.is_stopped()) and not JumpBufferTimer.is_stopped():
			velocity.y = jump_velocity

		# Get the input direction and handle the movement/deceleration.
		direction = Input.get_axis("move_left", "move_right")
		if direction:
			if dashing:
				velocity.x = direction * dash_speed * speed_multipilier
			else:
				velocity.x = direction * speed * speed_multipilier
		else:
			velocity.x = move_toward(velocity.x, 0, speed * speed_multipilier)
			
		var was_on_floor = is_on_floor()

		move_and_slide()
		
		if was_on_floor and not is_on_floor():
			CoyoteTimer.start()

	#🐦‍⬛ CROW TRANSFORMATION
	elif $"Radial Menu/UI".form == "Transform 1":
		for i in $Animations.get_children():
			if i.name == "CrowFormAnims":
				i.visible = true
			else:
				i.visible = false
		
		direction = Input.get_axis("move_left", "move_right")
		speed = 10
		if direction:
			velocity.x = direction * speed * speed_multipilier
		else:
			velocity.x = move_toward(velocity.x, 0, speed * speed_multipilier)
			
		velocity.y += gravityget() * delta
			
		if Input.is_action_just_pressed("jump"):
			velocity.y = -FLAP_SPEED
		
		move_and_slide()
		
		if not is_on_floor() and velocity.y > 0:
			pass #falling
		elif not is_on_floor() and velocity.y < 0:
			pass #flying


	#🕯️MOTH TRANSFORMATION
	elif $"Radial Menu/UI".form == "Transform 2":
		for i in $Animations.get_children():
			if i.name == "MothFormAnims":
				i.visible = true
			else:
				i.visible = false
		
		direction = Input.get_axis("move_left", "move_right")
		speed = 6
		if direction:
			velocity.x = direction * speed * speed_multipilier
		else:
			velocity.x = move_toward(velocity.x, 0, speed * speed_multipilier)
			
		velocity.y += gravityget() * delta
			
		if Input.is_action_just_pressed("jump"):
			velocity.y = -FLAP_SPEED
		
		move_and_slide()
		
		if not is_on_floor() and velocity.y > 0:
			pass #falling
		elif not is_on_floor() and velocity.y < 0:
			pass #flying
		
		if Input.is_action_pressed("interact") and canShoot:
			canShoot = false
			shootNum += 1
			if shootNum >= 10:
				laser.rotation = (get_global_mouse_position() - global_position).angle()
				laser.setIsCasting(true)
				await get_tree().create_timer(3).timeout
				shootNum = 0
				laser.setIsCasting(false)
			else:
				var fb = fireball.instantiate()
				get_parent().add_child(fb)
				fb.global_position = global_position
				fb.direction = (get_global_mouse_position() - global_position).normalized()
				fb.rotation = fb.direction.angle()
				await get_tree().create_timer(1.0).timeout
			canShoot = true


	#🦅VULTURE TRANSFORMATION
	elif $"Radial Menu/UI".form == "Transform 3":
		for i in $Animations.get_children():
			if i.name == "VultureFormAnims":
				i.visible = true
			else:
				i.visible = false
				
		direction = Input.get_axis("move_left", "move_right")
		speed = 3
		if direction:
			velocity.x = direction * speed * speed_multipilier
		else:
			velocity.x = move_toward(velocity.x, 0, speed * speed_multipilier)
			
		velocity.y += gravityget() * delta
			
		if Input.is_action_just_pressed("jump"):
			velocity.y = -FLAP_SPEED
		
		move_and_slide()
		
		if not is_on_floor() and velocity.y > 0:
			pass #falling
		elif not is_on_floor() and velocity.y < 0:
			pass #flying
	
	#🌹FLOWER TRANSFORMATION
	elif $"Radial Menu/UI".form == "Transform 4":
		for i in $Animations.get_children():
			if i.name == "FlowerFormAnims":
				i.visible = true
			else:
				i.visible = false
				
		velocity.y += gravityget() * delta
	
	#⌛HOURGLASS TRANSFORMATION
	elif $"Radial Menu/UI".form == "Transform 5":
		for i in $Animations.get_children():
			if i.name == "HourglassFormAnims":
				i.visible = true
				
				if canAbilityH and !$"../Shaders".is_playing():
					canAbilityH = false
					$"../Shaders".play("timeStopIn")
					await $"../Shaders".animation_finished
					$"../Shaders".play("timeStopOut")
					await $"../Shaders".animation_finished
					await get_tree().create_timer(3.0).timeout
					canAbilityH=true
			else:
				i.visible = false

	if Input.is_action_just_pressed("transformation"):
		$SelectionWheel.show()
	elif Input.is_action_just_released("transformation"):	
		$SelectionWheel.Close()
	
func gravityget() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

# dashing
func _on_dash_timer_timeout() -> void:
	dashing = false
func _on_dash_cooldown_timeout() -> void:
	can_dash = true

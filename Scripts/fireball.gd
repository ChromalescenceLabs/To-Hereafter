extends Area2D

var speed = 500
var direction = Vector2.ZERO


func _physics_process(delta):
	global_position += direction * speed * delta
	$fireball/fire/fire.emitting = true

func _on_body_entered(body):
	if body is not Player:
		#if not certain mobs then damage lower
		#else higher
		$fireball/fire/fire.emitting = false
		$fireball/explosion/explosion.emitting = true
		await get_tree().create_timer($fireball/explosion/explosion.lifetime).timeout
		queue_free()

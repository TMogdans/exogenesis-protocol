class_name Bullet
extends Projectile

var damage: float = 1.0
var speed: float = 800.0
var can_bounce: bool = false
var bounce_count: int = 0
var can_split: bool = false
var split_count: int = 0
var direction = Vector2(1,0)
const scene: PackedScene = preload("res://Projectiles/Bullet/bullet.tscn")

func set_direction(dir: Vector2) -> void:
	direction = dir.normalized()

func _process(delta):
	var motion = direction * speed * delta
	
	var collision = move_and_collide(motion)
	if collision:
		_handle_collision(collision, delta)

func _handle_collision(collision, delta) -> void:
	var collider = collision.get_collider()
	if collider.is_in_group("enemies"):
		if collider.has_method("take_damage"):
			collider.take_damage(damage)
	
	if can_bounce:
		_handle_bounce(collision, delta)
	elif can_split:
		_handle_split(collision, delta)
	else:
		queue_free()

func _handle_bounce(collision, delta) -> void:
	var collision_normal = collision.get_normal()
	if bounce_count > 0:
		direction = direction.bounce(collision_normal).normalized()
		bounce_count -= 1
		var remaining_movement = speed * delta * direction
		position += remaining_movement
	else:
		queue_free()

func _handle_split(collision, delta) -> void:
	print_debug("split")
	pass

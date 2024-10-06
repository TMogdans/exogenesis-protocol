class_name Bullet
extends Projectile

var damage: float = 1.0
var speed: float = 800.0
var can_bounce: bool = false
var bounce_count: int = 0
var can_split: bool = false
var split_count: int = 0
var direction = Vector2(1,0)
var can_damage: int = 1
const scene: String = "res://Projectiles/Bullet/bullet.tscn"

func set_direction(dir: Vector2) -> void:
	direction = dir.normalized()

func _process(delta):
	var motion = direction * speed * delta
	
	var collision = move_and_collide(motion)
	
	if can_damage > 0:
		can_damage -= 1
		return
	else:
		set_collision_mask_value(3, true)
	
	if collision:
		_handle_collision(collision, delta)

func _handle_collision(collision, delta) -> void:
	var collider = collision.get_collider()
	
	if collider.is_in_group("enemies"):
		if collider.has_method("take_damage"):
			collider.take_damage(damage)
	
	if can_bounce and bounce_count > 0:
		_handle_bounce(collision, delta)
	elif can_split:
		_handle_split()
	else:
		queue_free()

func _handle_bounce(collision, delta) -> void:
	var collision_normal = collision.get_normal()
	if bounce_count > 0:
		direction = direction.bounce(collision_normal).normalized()
		bounce_count -= 1
		var remaining_movement = speed * delta * direction
		position += remaining_movement

func _handle_split() -> void:	
	@warning_ignore("integer_division")
	var angle = 360 / split_count
	for count in split_count:
		_create_split_bullet(angle * count)
			
	queue_free()

func _create_split_bullet(angle: int) -> void:
	var newBullet = duplicate()
	newBullet.velocity = velocity
	newBullet.position = position
	newBullet.scale = Vector2(0.75, 0.75)
	newBullet.set_collision_mask_value(3, false)
	newBullet.set_direction(Vector2(cos(deg_to_rad(angle)), sin(deg_to_rad(angle))))
	get_parent().add_child(newBullet)

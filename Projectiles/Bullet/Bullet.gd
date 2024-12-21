class_name Bullet
extends Projectile

const BASE_DAMAGE: float = 1.0
const BASE_SPEED: float = 800.0
const SCENE_PATH: String = "res://Projectiles/Bullet/bullet.tscn"
const SPLIT_SCALE: Vector2 = Vector2(0.75, 0.75)
var damage: float = BASE_DAMAGE
var speed: float = BASE_SPEED
var direction: Vector2 = Vector2.RIGHT
var can_bounce: bool = false
var bounce_count: int = 0
var can_split: bool = false
var split_count: int = 0
var can_damage: int = 1

func set_direction(dir: Vector2) -> void:
	direction = dir.normalized()

func _physics_process(delta: float) -> void:
	if _handle_damage_delay():
		return
		
	var motion: Vector2 = direction * speed * delta
	rotation = direction.angle()
	
	var collision: KinematicCollision2D = move_and_collide(motion)
	if collision:
		_handle_collision(collision, delta)

func _handle_damage_delay() -> bool:
	if can_damage > 0:
		can_damage -= 1
		return true
	else:
		set_collision_mask_value(3, true)
		return false

func _handle_collision(collision: KinematicCollision2D, delta: float) -> void:
	var collider: Node = collision.get_collider()
	
	if _handle_enemy_collision(collider):
		return
	
	if can_bounce and bounce_count > 0:
		_handle_bounce(collision, delta)
	elif can_split:
		_handle_split()
	else:
		FactoryProjectile.return_projectile(self)
		queue_free()

func _handle_enemy_collision(collider: Node) -> bool:
	if collider.is_in_group("enemies") and collider.has_method("take_damage"):
		collider.take_damage(damage)
		return true
	return false

func _handle_bounce(collision: KinematicCollision2D, delta: float) -> void:
	if bounce_count <= 0:
		return
		
	var collision_normal: Vector2 = collision.get_normal()
	direction = direction.bounce(collision_normal).normalized()
	bounce_count -= 1
	
	var remaining_movement: Vector2 = speed * delta * direction
	position += remaining_movement

func _handle_split() -> void:    
	if split_count <= 0:
		return
		
	@warning_ignore("integer_division")
	var angle: float = 360.0 / split_count
	
	for count in split_count:
		_create_split_bullet(angle * count)
			
	FactoryProjectile.return_projectile(self)

func _create_split_bullet(angle: float) -> void:
	var new_bullet: Bullet = duplicate()
	new_bullet.velocity = velocity
	new_bullet.position = position
	new_bullet.scale = SPLIT_SCALE
	new_bullet.set_collision_mask_value(3, false)
	new_bullet.set_direction(Vector2(cos(deg_to_rad(angle)), sin(deg_to_rad(angle))))
	get_parent().add_child(new_bullet)

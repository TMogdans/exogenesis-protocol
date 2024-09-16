class_name Laser
extends Projectile

var damage: float = 3.0
var speed: float = 1500.0
var can_bounce: bool = false
var can_split: bool = false
var direction = Vector2(1,0)
const scene: PackedScene = preload("res://Projectiles/Laser/laser.tscn")

func _process(delta):
	position += direction * speed * delta

func _on_body_entered(body) -> void:
	if body.is_in_group("enemies"):
		if body.has_method("take_damage"):
			body.take_damage(damage)
	
	queue_free()

func set_direction(dir: Vector2) -> void:
	direction = dir.normalized()

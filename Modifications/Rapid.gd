class_name Rapid
extends Modification

var add_speed_percentage: float = 20.0

func apply(projectile: Projectile) -> void:
	projectile.speed *= 1 + add_speed_percentage / 100

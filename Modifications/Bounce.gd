class_name Bounce
extends Modification

func apply(projectile: Projectile) -> void:
	projectile.can_bounce = true
	projectile.bounce_count += 3

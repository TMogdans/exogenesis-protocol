class_name Split
extends Modification

func apply(projectile: Projectile) -> void:
	projectile.can_split = true
	projectile.split_count += 3

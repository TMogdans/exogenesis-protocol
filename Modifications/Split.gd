class_name Split
extends Modification

## The number of additional projectiles to create 
const SPLIT_COUNT := 3

func apply(projectile: Projectile) -> void:
	if not projectile:
		return
	projectile.can_split = true
	projectile.split_count += SPLIT_COUNT

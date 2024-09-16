class_name DamageIncrease
extends Modification

var add_damage_percentage: float = 20.0

func apply(projectile: Projectile) -> void:
	projectile.damage *= 1 + add_damage_percentage / 100

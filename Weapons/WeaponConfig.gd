# WeaponConfig.gd
class_name WeaponConfig
extends Resource

@export_group("Base Settings")
@export var max_slots := 4
@export var base_cooldown := 0.5

@export_group("Projectile Settings")
@export var laser_settings := {
	"max_speed_multiplier": 3.0,
	"max_split_count": 9,
	"max_bounce_count": 3,
	"pool_initial_size": 10,
	"pool_max_size": 30
}
@export var bullet_settings := {
	"max_speed_multiplier": 2.0,
	"max_split_count": 5,
	"max_bounce_count": 2,
	"pool_initial_size": 20,
	"pool_max_size": 50
}

func _init() -> void:
	# Standardwerte setzen, falls keine Resource geladen wurde
	if max_slots <= 0:
		max_slots = 4
	if base_cooldown <= 0:
		base_cooldown = 0.5
	
	# Standardwerte für Projektiltypen setzen, falls nicht definiert
	if not laser_settings.has("max_speed_multiplier"):
		laser_settings["max_speed_multiplier"] = 3.0
	if not laser_settings.has("max_split_count"):
		laser_settings["max_split_count"] = 9
	if not laser_settings.has("max_bounce_count"):
		laser_settings["max_bounce_count"] = 3
	if not laser_settings.has("pool_initial_size"):
		laser_settings["pool_initial_size"] = 10
	if not laser_settings.has("pool_max_size"):
		laser_settings["pool_max_size"] = 30
	
	if not bullet_settings.has("max_speed_multiplier"):
		bullet_settings["max_speed_multiplier"] = 2.0
	if not bullet_settings.has("max_split_count"):
		bullet_settings["max_split_count"] = 5
	if not bullet_settings.has("max_bounce_count"):
		bullet_settings["max_bounce_count"] = 2
	if not bullet_settings.has("pool_initial_size"):
		bullet_settings["pool_initial_size"] = 20
	if not bullet_settings.has("pool_max_size"):
		bullet_settings["pool_max_size"] = 50

func get_projectile_settings(projectile_type: String) -> Dictionary:
	match projectile_type:
		"LASER":
			return laser_settings
		"BULLET":
			return bullet_settings
		_:
			push_error("Unknown projectile type: " + projectile_type)
			return {}

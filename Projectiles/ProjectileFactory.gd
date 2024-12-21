# ProjectileFactory.gd
class_name ProjectileFactory
extends Node

const PROJECTILE_SCENES = {
	'LASER': "res://Projectiles/Laser/laser.tscn",
	'BULLET': "res://Projectiles/Bullet/bullet.tscn"
}

var _pools: Dictionary = {}
var _config: WeaponConfig

func _init() -> void:
	if not _config:
		_config = WeaponConfig.new()
	_initialize_pools()

func _initialize_pools() -> void:
	for type in PROJECTILE_SCENES.keys():
		var scene_path = PROJECTILE_SCENES[type]
		var settings = _config.get_projectile_settings(type)
		_pools[type] = ProjectilePool.new(scene_path, settings)

func get_projectile(type: String) -> Projectile:
	if _pools.has(type):
		return _pools[type].get_projectile()
	push_error("Unknown projectile type: " + str(type))
	return null

func return_projectile(projectile: Projectile) -> void:
	var type = _get_projectile_type(projectile)
	if _pools.has(type):
		_pools[type].return_projectile(projectile)
	else:
		push_error("Unknown projectile type: " + str(type))
		projectile.queue_free()

func _get_projectile_type(projectile: Projectile) -> String:
	for type in PROJECTILE_SCENES.keys():
		if projectile.SCENE_PATH == PROJECTILE_SCENES[type]:
			return type
	return ""

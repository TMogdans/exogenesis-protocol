class_name ProjectilePool
extends Node

var _pool: Array[Projectile] = []
var _config: Dictionary
var _scene_path: String

func _init(scene_path: String, config: Dictionary) -> void:
	_scene_path = scene_path
	_config = config
	_initialize_pool()

func _initialize_pool() -> void:
	for i in _config.pool_initial_size:
		var projectile = create_new_projectile()
		return_projectile(projectile)

func get_projectile() -> Projectile:
	if not _pool.any(func(element): return element != null):
		return create_new_projectile()
	return _pool.pop_back()

func return_projectile(projectile: Projectile) -> void:
	if not is_instance_valid(projectile):
		return
	
	if _pool.size() >= _config.pool_max_size:
		projectile.queue_free()
		return
	
	# Reset projectile state
	projectile.can_split = false
	projectile.split_count = 0
	projectile.can_bounce = false
	projectile.bounce_count = 0
	projectile.speed = projectile.BASE_SPEED
	projectile.damage = projectile.BASE_DAMAGE
	
	projectile.queue_free()
	_pool.append(projectile)

func create_new_projectile() -> Projectile:
	return load(_scene_path).instantiate() as Projectile

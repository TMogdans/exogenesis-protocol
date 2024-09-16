extends CharacterBody2D

@export var enemy_type: Enemy = null

@onready var timer: Timer = $Timer

var move_direction: Vector2 = Vector2.ZERO
var current_state: Enemy.STATE = Enemy.STATE.IDLE
var current_hp: int = 0
var rng = RandomNumberGenerator.new()
var close_combat_cooldown: int = 0

func _ready() -> void:
	current_hp = enemy_type.hp
	select_new_state()

func _physics_process(delta: float) -> void:
	if close_combat_cooldown > 0:
		close_combat_cooldown -= 1 * delta
		
	if(current_state == enemy_type.STATE.WALK):
		velocity = move_direction * enemy_type.move_speed

		var collision = move_and_collide(velocity * delta)
		if collision:
			if collision.get_collider().has_method("take_damage_from_collision"):
				if close_combat_cooldown <= 0:
					collision.get_collider().take_damage_from_collision(enemy_type.close_combat_damage)
					close_combat_cooldown = enemy_type.close_combat_cooldown

func take_damage(dmg: float) -> void:
	current_hp -= dmg
	print_debug("taking %f damage" % dmg)
	
	if current_hp <= 0:
		queue_free()

func select_new_direction():
	move_direction = Vector2(
		randi_range(-1, 1),
		randi_range(-1, 1)
	)

func select_new_state():
	
	if(current_state == Enemy.STATE.IDLE):
		current_state = Enemy.STATE.WALK
		select_new_direction()
		var min_ttl = enemy_type.move_time - enemy_type.move_time * enemy_type.time_threshold
		var max_ttl = enemy_type.move_time + enemy_type.move_time * enemy_type.time_threshold
 
		timer.start(rng.randf_range(min_ttl, max_ttl))
	elif(current_state == Enemy.STATE.WALK):
		current_state = Enemy.STATE.IDLE
		var min_ttl = enemy_type.idle_time - enemy_type.idle_time * enemy_type.time_threshold
		var max_ttl = enemy_type.idle_time + enemy_type.idle_time * enemy_type.time_threshold
		
		timer.start(rng.randf_range(min_ttl, max_ttl))

func _on_timer_timeout():
	select_new_state()

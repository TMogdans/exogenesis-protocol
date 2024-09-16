extends CharacterBody2D

@export var speed = 300

@onready var object_rotator: Node2D = $ObjectRotator

func _physics_process(_delta: float) -> void:
	get_input()
	_rotate_hand()
	move_and_slide()

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _rotate_hand() -> void:
	object_rotator.look_at(get_global_mouse_position())

func take_damage_from_collision(damage: int) -> void:
	print_debug("Damage taken: ", damage)

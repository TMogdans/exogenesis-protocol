extends CharacterBody2D

@export var speed = 300

@onready var object_rotator: Node2D = $ObjectRotator
@onready var interact_label: Label = $Area2D/Label

var selected_item: int = 0

func _physics_process(_delta: float) -> void:
	get_input()
	_rotate_hand()
	move_and_slide()

func get_input():
	if Input.is_action_just_pressed("interact") and selected_item != 0:
		var instance = instance_from_id(selected_item)
		if instance.has_method("pickup"):
			EventBus.emit_signal("item_pickedup", selected_item)
		
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _rotate_hand() -> void:
	object_rotator.look_at(get_global_mouse_position())

func take_damage_from_collision(damage: int) -> void:
	print_debug("Damage taken: ", damage)

func _on_body_entered(body: Node2D) -> void:
	print_debug("entered")
	if body.has_method("can_interact"):
		interact_label.visible = true
		print_debug(body.can_interact())
		selected_item = body.can_interact()

func _on_body_exited(body: Node2D) -> void:
	interact_label.visible = false
	selected_item = 0

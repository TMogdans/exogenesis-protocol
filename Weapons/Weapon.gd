class_name Weapon
extends Sprite2D

@export var max_slots = 4
@export var cooldown: float = 0.5

@onready var object_rotator: Node2D = $".."
@onready var cooldownTimer: Timer = $Cooldown

var slots: Array
var current_slot_index = 0
var _can_shoot: bool = true
var _in_inventory: bool = false

func _ready() -> void:
	slots.resize(max_slots)
	cooldownTimer.wait_time = cooldown
	
	EventBus.inventory_entered.connect(_on_inventory_entered)
	EventBus.inventory_exited.connect(_on_inventory_exited)
	EventBus.modifier_inserted.connect(_on_modifier_added)
	
func _process(_delta: float) -> void:
	get_input()
	
func get_input():
	if Input.is_action_pressed("shoot"):
		shoot()

func shoot() -> void:
	if not _can_shoot or _in_inventory:
		return
	
	_can_shoot = false
	cooldownTimer.start()
	
	var modifiers = []
	var iterations = 0
	
	while iterations < slots.size():
		var item = slots[current_slot_index]
		
		if item is Projectile:
			var projectile = apply_modifiers_to_projectile(modifiers, load(item.scene).instantiate())
			var direction = Vector2(cos(object_rotator.global_rotation), sin(object_rotator.global_rotation))
			
			projectile.transform = global_transform
			projectile.set_direction(direction)
			
			owner.owner.add_child(projectile)

			current_slot_index = (current_slot_index + 1) % slots.size()
			return
		elif item is Modification:
			modifiers.append(item)
			
		current_slot_index = (current_slot_index + 1) % slots.size()
		iterations += 1
	
	current_slot_index = 0
	modifiers = []

func apply_modifiers_to_projectile(modifiers: Array, projectile: Projectile) -> Projectile:
	for modifier: Modification in modifiers:
		modifier.apply(projectile)
		
	return projectile

func _on_gun_cooldown_timeout():
	_can_shoot = true

func _on_inventory_entered() -> void:
	_in_inventory = true
	
func _on_inventory_exited() -> void:
	_in_inventory = false

func _on_modifier_added(modifier: ItemData, slotNumber: int) -> void:
	slots[slotNumber] = load(modifier.scriptPath).new()

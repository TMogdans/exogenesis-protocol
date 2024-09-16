class_name Enemy
extends Resource

@export var hp: int = 5
@export var move_speed: int = 20
@export var move_time: int = 5
@export var idle_time: int = 5
@export var time_threshold: float = 0.1
@export var close_combat_damage: int = 1   # amount of damage
@export var close_combat_cooldown: int = 1 # damage every x seconds

enum STATE { IDLE, WALK }

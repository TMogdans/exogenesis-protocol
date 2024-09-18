class_name Item
extends Node

enum TYPE { PROJECTILE, WEAPON_MOD, PROJECTILE_MOD }

@export var icon: Texture2D = null
@export var type: TYPE
@export var resource: Resource


func can_interact() -> int:
	return get_instance_id()
	
func pickup() -> Item:
	return self

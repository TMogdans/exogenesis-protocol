extends StaticBody2D

@export var data: WeaponData

func _ready() -> void:
	%Sprite.texture = data.texture

func can_interact() -> int:
	return get_instance_id()

func pickup() -> WeaponData:
	return data

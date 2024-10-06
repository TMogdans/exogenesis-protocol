extends StaticBody2D

@export var data: ItemData

func _ready() -> void:
	%Sprite.texture = data.texture

func can_interact() -> int:
	return get_instance_id()

func pickup() -> ItemData:
	return data

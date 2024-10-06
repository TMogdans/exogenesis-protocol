class_name InventoryItem
extends TextureRect

@export var data: ItemData

func init(itemData: ItemData) -> void:
	data = itemData

func _ready() -> void:
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	texture = data.texture
	tooltip_text = "%s\n%s" % [data.name, data.description]

func _get_drag_data(at_position: Vector2) -> Variant:
	set_drag_preview(make_drag_preview(at_position))
	return self

func make_drag_preview(at_position: Vector2) -> Control:
	var textureRect := TextureRect.new()
	textureRect.texture = texture
	textureRect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	textureRect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	textureRect.custom_minimum_size = size
	textureRect.modulate.a = 0.5
	textureRect.position = Vector2(-at_position)
	
	var control:= Control.new()
	control.add_child(textureRect)
	
	return control

class_name InventorySlot
extends PanelContainer

@export var type: ItemData.Type

func init(itemType: ItemData.Type, minimum_size: Vector2) -> void:
	type = itemType
	custom_minimum_size = minimum_size

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data is InventoryItem:
		if type == ItemData.Type.MAIN:
			if get_child_count() == 0:
				return true
			else:
				if type == data.get_parent().type:
					return true
			return get_child(0).data.type == data.data.type
		else:
			return data.data.type
	return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if get_child_count() > 0:
		var item := get_child(0)
		if item == data:
			return
		item.reparent(data.get_parent())
	data.reparent(self)

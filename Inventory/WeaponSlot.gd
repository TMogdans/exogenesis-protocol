class_name WeaponSlot
extends PanelContainer

@export var type: ItemData.Type
var slotNumber: int = -1

func init(itemType: ItemData.Type, minimum_size: Vector2, slot_number: int) -> void:
	type = itemType
	custom_minimum_size = minimum_size
	slotNumber = slot_number

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
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

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	if get_child_count() > 0:
		var item := get_child(0)
		if item == data:
			return
		item.reparent(data.get_parent())
	data.reparent(self)
		
	EventBus.emit_signal("modifier_inserted", data.data, slotNumber)

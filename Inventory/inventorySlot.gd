class_name InventorySlot
extends Node

var item: Item

@onready var icon: TextureRect = $Icon
var inventory: Inventory

func set_item(new_item: Item) -> void:
	item = new_item
	
	if item == null:
		icon.visible = false
	else:
		icon.visible = true
		icon.texture = item.icon

func add_item() -> void:
	pass

func remove_item() -> void:
	set_item(null)


func _on_mouse_entered() -> void:
	EventBus.emit_signal("inventory_entered")


func _on_mouse_exited() -> void:
	EventBus.emit_signal("inventory_exited")

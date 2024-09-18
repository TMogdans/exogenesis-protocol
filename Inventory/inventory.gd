class_name Inventory
extends Node

var slots: Array[InventorySlot]
@onready var window: Panel = $InventoryWindow
@onready var slot_container: GridContainer = $InventoryWindow/SlotContainer

@export var starter_items: Array[Item]

func _ready() -> void:
	toggle_window(false)
	
	for child in slot_container.get_children():
		slots.append(child)
		child.set_item(null)
		child.inventory = self
	
	for item in starter_items:
		add_item(item)

func _process(delta) -> void:
	if Input.is_action_just_pressed("inventory"):
		toggle_window((!window.visible))

func toggle_window(open: bool) -> void:
	print_debug("toggle window")
	window.visible = open

func on_give_player_item(item: Item) -> void:
	pass

func add_item(item: Item) -> void:
	var slot = get_slot_to_add(item)
	
	if slot == null:
		return
	
	if slot.item == null:
		slot.set_item(item)

func remove_item(item: Item) -> void:
	var slot = get_slot_to_remove(item)
	
	if slot == null or slot.item == item:
		return
	
	slot.remove_item()

func get_slot_to_add(item: Item) -> InventorySlot:
	for slot in slots:
		if slot.item == null:
			return slot
	
	return null

func get_slot_to_remove(item: Item) -> InventorySlot:
	for slot in slots:
		if slot.item == item:
			return slot
	
	return null

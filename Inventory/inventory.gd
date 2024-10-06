extends Node

var inventorySize: int = 12

# for testing
var items = [
	"res://Inventory/Items/ModBounce.tres",
	"res://Inventory/Items/ModDamageUp.tres",
	"res://Inventory/Items/ProjBullet.tres",
	"res://Inventory/Items/ProjLaser.tres"
]

func _ready() -> void:
	%InventoryGrid.columns = inventorySize
	
	for i in inventorySize:
		var slot := InventorySlot.new()
		slot.init(ItemData.Type.MAIN, Vector2(32, 32))
		%InventoryGrid.add_child(slot)
	
	#for testing
	for i in items.size():
		var item := InventoryItem.new()
		item.init(load(items[i]))
		%InventoryGrid.get_child(i).add_child(item)
	
	EventBus.item_pickedup.connect(_on_item_pickedup)

func _process(_delta):
	if Input.is_action_just_pressed("inventory"):
		%InventoryGrid.visible = !%InventoryGrid.visible

func _on_item_pickedup(instanceId: int) -> void:
	var slot = _find_empty_slot()
	if slot != -1:
		var instance = instance_from_id(instanceId)
		if instance.has_method("pickup"):
			var data = instance.pickup()
			add_item(slot, data)
			instance.queue_free()

func _find_empty_slot() -> int:
	for i in %InventoryGrid.get_child_count():
		if %InventoryGrid.get_child(i).get_child_count() == 0:
			return i
	return -1

func add_item(slot: int, data: ItemData):
	var item := InventoryItem.new()
	item.init(data)
	%InventoryGrid.get_child(slot).add_child(item)


func _on_panel_mouse_entered() -> void:
	EventBus.emit_signal("inventory_entered")


func _on_panel_mouse_exited() -> void:
	EventBus.emit_signal("inventory_exited")

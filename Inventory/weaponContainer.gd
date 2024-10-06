extends VBoxContainer

var slotCount: int = 4
var mods: Array = []

func _ready() -> void:
	%ModGrid.columns = slotCount
	
	for i in slotCount:
		var slot := InventorySlot.new()
		slot.init(ItemData.Type.MAIN, Vector2(32, 32))
		%ModGrid.add_child(slot)

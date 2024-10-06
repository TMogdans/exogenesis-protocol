extends VBoxContainer

var slotCount: int = 4
var mods: Array = []

func _ready() -> void:
	%ModGrid.columns = slotCount
	
	for i in slotCount:
		var slot := WeaponSlot.new()
		slot.init(ItemData.Type.MAIN, Vector2(32, 32), i)
		%ModGrid.add_child(slot)

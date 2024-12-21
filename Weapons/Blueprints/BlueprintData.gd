class_name BlueprintData
extends Resource

enum Type { PISTOL, RIFLE, ASSAULT, LAUNCHER, MINIGUN }

@export var type: Type
@export var name: String
@export var texture: Texture2D
@export var rangeRange: Vector2
@export var fireRateRange: Vector2
@export var maxHeatRange: Vector2i
@export var coolingRateRange: Vector2
@export var slotCountRange: Vector2i

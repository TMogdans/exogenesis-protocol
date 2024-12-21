class_name WeaponData
extends Resource

enum Type { PISTOL, RIFLE, ASSAULT, LAUNCHER, MINIGUN }
enum Quality { NORMAL, RARE, EPIC, LEGENDARY, MYTHIC }

@export var type: Type
@export var name: String
@export var description: String
@export var texture: Texture2D
@export var fireRate: float
@export var maxHeat: int
@export var coolingRate: float
@export var slotCount: int
@export var quality: Quality

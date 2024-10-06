class_name ItemData
extends Resource

enum Type {WEAPON_MOD, PROJECTILE_MOD, PROJECTILE, MAIN}

@export var type: Type
@export var name: String
@export var description: String
@export var texture: Texture2D
@export var scriptPath: String

class_name ItemData
extends Resource

enum Type {WEAPON_MOD, PROJECTILE_MOD, PROJECTILE, MAIN}

const WEAPON_MOD = 0
const PROJECTILE_MOD = 1
const PROJECTILE = 2
const MAIN = 3

@export var type: Type
@export var name: String
@export var description: String
@export var texture: Texture2D
@export var scriptPath: String

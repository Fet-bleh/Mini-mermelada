extends Area2D
class_name Machine

@export var submenu_scene: PackedScene
signal interacted(machine_node)

func _ready():
	add_to_group("machines")

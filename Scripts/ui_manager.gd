extends Node

@onready var ui_layer: CanvasLayer = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	for machine in get_tree().get_nodes_in_group("machines"):
		machine.interacted.connect(machine_interact)

func machine_interact(machine : Machine) -> void:
	print(self)
	var submenu = machine.submenu_scene.instantiate()
	ui_layer.add_child(submenu)
	submenu.global_position = machine.global_position + Vector2(0, 0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

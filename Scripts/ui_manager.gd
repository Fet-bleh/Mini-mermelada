extends Node
@onready var ui_layer: CanvasLayer = $".."

func _ready():
	for machine in get_tree().get_nodes_in_group("machines"):
		machine.interacted.connect(machine_interact)

func machine_interact(machine : Machine) -> void:
	clean_all()
	var submenu = machine.submenu_scene.instantiate()
	ui_layer.add_child(submenu)
	if submenu.get_child(0) is PanelContainer:
		submenu.global_position = machine.global_position - submenu.get_child(0).size/2 + Vector2(0, 220)
	if submenu.has_method("setup"):
		print(machine)
		submenu.setup(machine)

func clean_all() -> void:
	for child in ui_layer.get_children():
		if child.name != "UIManager":
			child.queue_free()
func _process(delta):
	pass

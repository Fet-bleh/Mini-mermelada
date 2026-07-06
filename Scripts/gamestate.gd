extends Node

var dineros: int=0
var sospecha: int=0

func add_dinero(dinerose: int):
	dineros += dinerose

func reset():
	dineros = 0
	sospecha = 0
	GameManager.reset()

var dead_scene_instance = null

func managerEnd():
	var dead = load("res://Scenes/dead.tscn")
	var dead_scene_instance = dead.instantiate()
	dead_scene_instance.add_to_group("death_overlay")
	dead_scene_instance.get_node("PanelContainer/MarginContainer/VBoxContainer/Money").text = str(dineros)
	get_tree().root.add_child(dead_scene_instance)

func gameover():
	for overlay in get_tree().get_nodes_in_group("death_overlay"):
		overlay.free()
	reset()
	var main = get_tree().get_first_node_in_group("main_scene")
	var spawner = main.get_node("Spawner")
	
	for child in spawner.get_children():
		if child is Timer:
			child.stop()
	
	for producto in get_tree().get_nodes_in_group("productos"):
		producto.free()
	
	get_tree().root.remove_child(main)
	main.free()
	
	var main_scene_resource = load("res://Scenes/node_2d.tscn")
	var new_main = main_scene_resource.instantiate()
	get_tree().root.add_child(new_main)
	get_tree().current_scene = new_main

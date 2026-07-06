extends Node2D

var hand_cursor
# Called when the node enters the scene tree for the first time.
func _ready():
	for machine in get_tree().get_nodes_in_group("machines"):
		machine.mouse_entered.connect(area2d_mouse_enter)
		machine.mouse_exited.connect(area2d_mouse_exit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#mouse de mano cuando entra en un area, conectar cuando cree un objeto ##obj.mouse_entered.connect(area2d_mouse_enter)
func area2d_mouse_enter():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

#mouse de mano cuando sale de un area, conectar cuando cree un objeto  ##obj.mouse_exited.connect(area2d_mouse_exit)
func area2d_mouse_exit():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

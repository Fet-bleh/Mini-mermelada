extends Node2D

const virus = preload("res://Anuncio_malo_grrr.tscn")
var n = randi_range(1, 3)




# vvairu
func _on_timer_timeout() -> void:
	var virus_inst = virus.instantiate()
	var n = randi() % 5
	virus_inst.scale *= n
	if n > 2: virus_inst.position = Vector2(randi_range(-128, 128), randi_range(48, -42))
	else:
		virus_inst.position = Vector2(randi_range(-371, 370), randi_range(121, -121))
	add_child(virus_inst)

extends Node2D

func _input_event(viewport, event, shape_idx):
		if event.is_action_pressed("click"):
			$"../../..".visible = false
			

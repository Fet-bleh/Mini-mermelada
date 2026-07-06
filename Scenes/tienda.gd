extends Machine


# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group("tienda")
	input_event.connect(_on_area_maquina_input_event)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func _on_area_maquina_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click"):
		interacted.emit(self)
		print(self)

extends Machine

#falta definir la textura
@export var texturas: Dictionary = {"bueno": Texture2D, "neutral": Texture2D, "terrible": Texture2D}
@export var dinero: Dictionary = {"bueno": 10, "neutral": -10, "terrible": -30}
@export var probabilidad: Dictionary = {"bueno": 0.8, "neutral": 0.125, "terrible": 0.075}
@export var sospecha: Dictionary = {"bueno": -10, "neutral": 10, "terrible": 25}

func _ready():
	input_event.connect(_on_area_maquina_input_event)
	area_entered.connect(_on_area_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_entered(area: Area2D) -> void:
	if not area.is_in_group("producto"):
		return
	var resultado = elegir_caso()
	print(resultado)
	#area.apply_texture(resultado, texturas[resultado])


func elegir_caso() -> String:
	var total := 0.0
	for i in probabilidad.values():
		total +=  i
	var r := randf()*total
	var cumulative := 0.0
	for caso in probabilidad.keys():
		cumulative += probabilidad[caso]
		if r <= cumulative: 
			return caso
	return probabilidad["terrible"]

func _on_area_maquina_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("click"):
		interacted.emit(self)
		print(self)

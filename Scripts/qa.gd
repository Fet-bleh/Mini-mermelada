extends Machine

var medidor_sospecha = 0
@export var texturas: Dictionary = {"bola": "res://Assets/figuritas individuales/mierdita.png" , "triangulo": "res://Assets/figuritas individuales/mierdita.png"}
@export var dinero: Dictionary = {"bueno": 10, "terrible": -30}
@export var probabilidad: Dictionary = {"bueno": 0.85, "terrible": 0.15}
@export var sospecha: Dictionary = {"bueno": -10, "terrible": 25}

func _ready():
	input_event.connect(_on_area_maquina_input_event)
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_entered(area: Area2D) -> void:
	area.get_child(1).visible = false
	if not area.is_in_group("producto"):
		return
	var resultado = elegir_caso()
	var animacion = resultado + " " + area.propiedades[-1] 
	$"../..".play(animacion, .8)
	medidor_sospecha = max(medidor_sospecha+sospecha[resultado], 0)
	#print(medidor_sospecha)
	if resultado == "bueno": 
		area.apply_texture(area.get_child(1).texture.resource_path, resultado, dinero[resultado])
	else:
		area.apply_texture(texturas[area.propiedades[-1]], resultado, dinero[resultado])
	

func _on_area_exited(area: Area2D) -> void:
	if not area.is_in_group("producto"):
		return
	area.get_child(1).visible = true
	$"../..".stop()

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

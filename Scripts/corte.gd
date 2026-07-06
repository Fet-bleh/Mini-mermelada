extends Machine

@export var texturas: Dictionary = {"mate": "res://Assets/figuritas individuales/triangulito mate.png", "trigo": "res://Assets/figuritas individuales/triangulo trigo.png", "mota": "res://Assets/figuritas individuales/triangulito mota.png"}
@export var dinero: Dictionary = {"bueno": 10, "terrible": -30}
@export var probabilidad: Dictionary = {"bueno": 0.7, "terrible": 0.3}
@export var sospecha: Dictionary = {"bueno": 5, "terrible": -30}

func _ready():
	super._ready()
	input_event.connect(_on_area_maquina_input_event)
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_entered(area: Area2D) -> void:
	if not area.is_in_group("producto"):
		return
	area.get_child(1).visible = false
	var resultado = elegir_caso()
	logOp(resultado, sospecha[resultado])
	var animacion = resultado + " " + area.propiedades[-1] 
	$"../..".play(animacion, 1.05)
	if resultado == "terrible": 
		area.apply_texture(area.get_child(1).texture.resource_path, "bola", dinero[resultado])
	else:
		area.apply_texture(texturas[area.propiedades[-1]], "triangulo", dinero[resultado])
	

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
		machine_name = "Cutting"
		interacted.emit(self)
		print(self)

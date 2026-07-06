extends Machine

var medidor_sospecha = 0
@export var texturas: Dictionary = {"bueno": "res://Assets/figuritas individuales/cajita argentina.png", "neutral": "res://Assets/figuritas individuales/cajita caboverdiana.png", "terrible": "res://Assets/figuritas individuales/cajita chilena.png"}
@export var dinero: Dictionary = {"bueno": 10, "neutral": -10, "terrible": -30}
@export var probabilidad: Dictionary = {"bueno": 0.6, "neutral": 0.25, "terrible": 0.15}
@export var sospecha: Dictionary = {"bueno": 10, "neutral": -10, "terrible": -20}
@export var tipo: Dictionary = {"bueno": "argentina", "neutral": "caboverde", "terrible": "chile"}

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
	var resultado = elegir_caso()
	logOp(resultado, sospecha[resultado])
	var animacion = resultado 
	$"../..".play(animacion, 1.1)
	await get_tree().create_timer(0.2).timeout
	area.get_child(1).visible = false
	area.speed += 12
	area.apply_texture(texturas[resultado], tipo[resultado], dinero[resultado])

func _on_area_exited(area: Area2D) -> void:
	if not area.is_in_group("producto"):
		return
	$"../..".stop()
	area.speed -= 12 
	area.get_child(1).visible = true
	print($"../..".animation)

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
		machine_name = "Packaging"
		interacted.emit(self)
		print(self)

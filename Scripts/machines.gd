extends Area2D
class_name Machine

@export var submenu_scene: PackedScene
signal interacted(machine_node)


const MAX_LOGS := 5

@export var machine_name: String = "Machine"
@export var minigame_scene: PackedScene

@export var calidad: int = 100

var ultimasOp: Array = [] 

signal cambio_op(calidad: float)

func _ready():
	add_to_group("machines")
	GameManager.register_machine(self)

func logOp(status: String, calidadCambio):
	ultimasOp.append({"status": status})
	if ultimasOp.size() > MAX_LOGS:
		ultimasOp.pop_front()
		

	var estaba_vivo = calidad > 0
	calidad = clamp(calidad + calidadCambio, 0.0, 100.0)
		
	cambio_op.emit(calidad)

func cambiar_calidad(value: int) -> void:
	var estaba_vivo = calidad > 0
	calidad = clamp(calidad + value, 0.0, 100.0)
	if calidad <= 0 and estaba_vivo:
		Gamestate.gameover()
	cambio_op.emit(calidad)

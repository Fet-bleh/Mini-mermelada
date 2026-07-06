extends Node

signal sospecha_cambio(sospecha: int)



var sospecha: int = 0:
	set(value):
		sospecha = clamp(value, 0.0, 250.0)
		sospecha_cambio.emit(sospecha)

var machines: Array[Machine] = []

func register_machine(machine: Machine) -> void:
	machines.append(machine)
	machine.cambio_op.connect(recalcular_sospecha)
	recalcular_sospecha(machine.calidad)

func recalcular_sospecha(calidad: int) -> void:
	var total_diff = 0
	for m in machines:
		total_diff += 100 - m.calidad
	sospecha = total_diff

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func reset():
	machines.clear()

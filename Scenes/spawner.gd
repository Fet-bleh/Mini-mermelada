extends Node2D
@export var ProductoEscena: PackedScene

var _timer: Timer
var intervalo: float = 1.8

func _ready():
	_timer = Timer.new()
	_timer.wait_time = intervalo
	_timer.autostart = true
	_timer.timeout.connect(spawn_producto)
	add_child(_timer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func spawn_producto() -> void:
	var producto = ProductoEscena.instantiate()
	producto.enviado.connect(en_despawn)
	add_child(producto)

func en_despawn(dinero: int) -> void:
	Gamestate.add_dinero(dinero)

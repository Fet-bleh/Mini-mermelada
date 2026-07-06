extends Control

const STATUS_ICON := {"bueno": "✅", "neutral": "⚠️", "terrible": "❌"}
const STATUS_COLOR := {"bueno": Color.GREEN, "neutral": Color.YELLOW, "terrible": Color.RED}
const STATUS_TEXTO := {"bueno": "Success", "neutral": "Warning", "terrible": "Error"}

@onready var MaquinaLabel: Label = $PanelContainer/Margen/main/MaquinaLabel
@onready var RecentOp: GridContainer = $PanelContainer/Margen/main/HBoxContainer/ColumnaIz/GridContainer
@onready var reparar: Button = $PanelContainer/Margen/main/HBoxContainer/ColumnaIz/reparador
@onready var condicion: ProgressBar = $PanelContainer/Margen/main/HBoxContainer/ColumnaDer/ProgressBar
@onready var close: Button = $Close
@onready var overlay: ColorRect = $Overlay

var machine : Machine
var danger_tween : Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	close.pressed.connect(queue_free)
	reparar.pressed.connect(reparar_interact)
	

func setup(target : Machine):
	machine = target
	MaquinaLabel.text = machine.machine_name
	machine.cambio_op.connect(_cambio)
	refresh(machine.calidad)

func refresh(value: int) -> void:
	for child in RecentOp.get_children():
		child.queue_free()
		
	if machine.ultimasOp.is_empty():
		var empty_label = Label.new()
		empty_label.text = "No operations logged yet."
		RecentOp.add_child(empty_label)
		return
	
	for op in machine.ultimasOp:
		var icon = Label.new()
		icon.text = STATUS_ICON[op.status]
		icon.add_theme_color_override("font_color", STATUS_COLOR[op.status])
		RecentOp.add_child(icon)
		var text = Label.new()
		text.text = STATUS_TEXTO[op.status]
		RecentOp.add_child(text)
	
	condicion.value = value

	var fill_color: Color
	if value < 30:
		fill_color = Color.RED
		start_flash()
	elif value < 60:
		fill_color = Color.YELLOW
		stop_flash()
	else:
		fill_color = Color.GREEN
		stop_flash()
	var style = StyleBoxFlat.new()
	style.bg_color = fill_color
	condicion.add_theme_stylebox_override("fill", style)

func _cambio(value: int) -> void:
	refresh(value)

func start_flash() -> void:
	if danger_tween and danger_tween.is_valid():
		return
	overlay.visible = true
	danger_tween = create_tween().set_loops()
	danger_tween.tween_property(overlay, "modulate:a", 0.35, 0.5)
	danger_tween.tween_property(overlay, "modulate:a", 0.0, 0.5)
	
func stop_flash() -> void:
	if danger_tween and danger_tween.is_valid():
		danger_tween.kill()
	overlay.visible = false
	overlay.modulate.a = 0.0

func reparar_interact() -> void:
	var repair = machine.minigame_scene.instantiate()
	get_tree().root.add_child(repair)
	hide()
	repair.repair_win.connect(on_repair_win, CONNECT_ONE_SHOT)

func on_repair_win(condicion_cambio: int) -> void:
	machine.cambiar_calidad(condicion_cambio)
	show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

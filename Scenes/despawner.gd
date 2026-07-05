extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("producto"):
		area.despawn()

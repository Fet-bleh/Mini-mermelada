extends PathFollow2D

@export var threshold: float = 70.0
@export var min_speed: float = 0.0
@export var max_speed: float = 100.0
@export var return_speed: float = 35.0

enum Facing { LEFT, RIGHT, FRONT, BACK }


@export var segments: Array = [
	{"end": 320.0, "facing": Facing.FRONT},   # forward-moving segment -> shows back
	{"end": 800.0, "facing": Facing.RIGHT},  # turn -> moving right
]

@onready var sprite: AnimatedSprite2D = $manager

func _ready():
	rotates = false  # facing handled by sprite swap, not node rotation

func _process(delta: float) -> void:
	var sospecha = GameManager.sospecha
	var prev_progress = progress
	if sospecha < threshold:
		progress = max(progress - return_speed * delta, 0.0)
		
	else:
		
		var t = (sospecha - threshold) / (300.0 - threshold)
		progress += lerp(min_speed, max_speed, t) * delta

	if progress != prev_progress:
		update_facing(progress > prev_progress)

func update_facing(forward: bool) -> void:
	for seg in segments:
		if progress <= seg.end:
			var facing = seg.facing
			if not forward:
				facing = _reversed(facing)
			_play_facing(facing)
			return

func _reversed(facing: int) -> int:
	match facing:
		Facing.LEFT: return Facing.RIGHT
		Facing.RIGHT: return Facing.LEFT
		Facing.FRONT: return Facing.BACK
		Facing.BACK: return Facing.FRONT
	return facing

func _play_facing(facing: int) -> void:
	match facing:
		Facing.LEFT: sprite.play("left")
		Facing.RIGHT: sprite.play("right")
		Facing.FRONT: sprite.play("front")
		Facing.BACK: sprite.play("back")

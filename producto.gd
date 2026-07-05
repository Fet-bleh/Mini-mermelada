extends Area2D
class_name Producto

signal enviado(dinero: int)

var speed = 100
var dinero = 50
@onready var sprite: Sprite2D = $ProductoSprite

func _ready() ->void:
	add_to_group("producto")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed*delta
	pass

func apply_texture(textura: Texture2D,  dinero_cambio: int = 0):
	sprite.texture = textura  
	dinero += dinero_cambio

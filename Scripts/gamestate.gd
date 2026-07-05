extends Node

var dinero: int=0
var sospecha: int=0

func add_dinero(dineros: int):
	dinero += dineros
	print(dinero)

func reset():
	dinero = 0
	sospecha = 0

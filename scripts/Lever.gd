extends StaticBody2D

onready var sprite = $Sprite

export var activated = false 

signal interaction

	
func interact():
	activated = not activated
	emit_signal("interaction")
	
	if activated:
		sprite.texture = load("res://img/Objetos/LeverOn.png")
	else:
		sprite.texture = load("res://img/Objetos/LeverOff.png")

func is_activated():
	return activated

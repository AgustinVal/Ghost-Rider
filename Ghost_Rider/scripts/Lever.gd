extends StaticBody2D

export var activated = false 

func interact():
	activated = not activated
	if activated:
		$Sprite.texture = load("res://img/Objetos/LeverOn.png")
	else:
		$Sprite.texture = load("res://img/Objetos/LeverOff.png")

func is_activated():
	return activated

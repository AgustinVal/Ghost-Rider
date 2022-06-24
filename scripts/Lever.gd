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

func onReach(shine):
	if shine:
		sprite.set_modulate(Color(0.48, 0.72, 1, 1))
	else:
		sprite.set_modulate(Color(1,1,1,1))

func is_activated():
	return activated

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		onReach(true)


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		onReach(false)

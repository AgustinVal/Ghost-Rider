extends KinematicBody2D

var linear_vel = Vector2.ZERO #Como obtengo la posicion del nodo¿?
var SPEED = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var target_velY = Input.get_action_strength("down") -   Input.get_action_strength("up")
	var target_velX = Input.get_action_strength("right") -  Input.get_action_strength("left")
	linear_vel.y = lerp(linear_vel.y, target_velY * SPEED, 0.5)
	linear_vel.x = lerp(linear_vel.x, target_velX * SPEED, 0.5)
	linear_vel = move_and_slide(linear_vel)

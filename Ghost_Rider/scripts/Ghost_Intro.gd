extends KinematicBody2D

var velocity = Vector2()
var SPEED = 200
var ACCELERATION = 500
var GRAVITY = 0.8
var timer = 0 #Para el movimiento del fantasma


func take_damage(Node2D): #Cuando reciba daño por la luz
	pass


func _physics_process(delta):
	timer += delta
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.y += GRAVITY * cos(timer)

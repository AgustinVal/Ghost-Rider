extends KinematicBody2D

var _target = null
var move= Vector2.ZERO
var SPEED=150
var ACCELERATION=100
var velocity =Vector2()


func _physics_process(delta):
	velocity = move_and_slide(velocity,Vector2.UP)
	var move_input =0
	if _target:
		move_input=(_target.global_position - global_position).normalized()
		velocity.x=move_toward(velocity.x, move_input.x*SPEED,ACCELERATION)
		velocity.y=move_toward(velocity.y, move_input.y*SPEED,ACCELERATION)
	else:
		velocity.x=0
		velocity.y=0

func _on_Area2D_body_entered(body):
	if body!= self and not body.is_in_group("Enemy"):
		_target= body

func _on_Area2D_body_exited(body):
	_target = null

func Scared(instigator: Node):
	var _move_input = (global_position - instigator.global_position).normalized()
	velocity.x=move_toward(velocity.x,_move_input.x*10*SPEED,ACCELERATION)
	velocity.x=move_toward(velocity.y,_move_input.x*10*SPEED,ACCELERATION)
	

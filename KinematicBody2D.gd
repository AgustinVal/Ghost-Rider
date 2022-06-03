extends KinematicBody2D

onready var anim_tree= $AnimationTree
onready var playback = anim_tree.get("parameters/playback")
onready var detection_area = $DetectionArea

var speed =100
var acceleration= 200
var _target: Node2D=null
var velocity=Vector2()

func _ready():
	anim_tree.active=true
	detection_area.connect("body_entered",self, "_on_body_entered")
	pass # Replace with function body.
	
func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	var move_input_x =0
	var move_input_y =0
	if _target:
		move_input_x = (_target.global_position - global_position).normalized().x
		move_input_y = (_target.global_position - global_position).normalized().y
	velocity.x = move_toward(velocity.x,move_input_x*speed,acceleration)	
	velocity.y = move_toward(velocity.y,move_input_y*speed,acceleration)



func se_asusta(instigator: Node2D):
	velocity = (global_position-instigator.global_position)* 0.5* speed
	
	
func _on_body_entered(body:Node2D):
	_target = body



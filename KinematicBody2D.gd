extends KinematicBody2D

onready var anim_tree= $AnimationTree
onready var playback = anim_tree.get("parameters/playback")
onready var detection_area = $DetectionArea
onready var Scare_area= $Pivot/ScareArea
onready var scare_spawn = $Pivot/ScareSpawn
onready var pivot = $Pivot
onready var hurtbox=$HurtBox
onready var ray_cast = $RayCast2D
var health = 100
var speed =100
var acceleration= 200
var _target: Node2D=null
var _target2: Node2D=null
var velocity=Vector2()
var insideTrap=false
var damage=0

export var scaring = false
var SoundWave = preload("res://scenes/SoundWave.tscn")

func _ready():
	anim_tree.active=true
	detection_area.connect("body_entered",self, "_on_body_entered")
	detection_area.connect("body_exited",self, "_on_body_exited")
	Scare_area.connect("body_entered",self, "_on_body_entered2")
	Scare_area.connect("body_exited",self, "_on_body_exited2")

func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	var move_input_x =0
	var move_input_y =0
	if _target:
		move_input_x = (_target.global_position - global_position).normalized().x
		move_input_y = (_target.global_position - global_position).normalized().y
		
	if move_input_x>0 and not move_input_x<0:
		pivot.scale.x = 1
	if move_input_x<0 and not move_input_x>0:
		pivot.scale.x = -1
	velocity.x = move_toward(velocity.x,move_input_x*speed*2,acceleration)	
	velocity.y = move_toward(velocity.y,move_input_y*speed*2,acceleration)
	if insideTrap:
		take_damage(damage)
		
func Scare():
	var wave =SoundWave.instance()
	get_parent().add_child(wave)
	wave.global_position = scare_spawn.global_position
	if pivot.scale.x < 0:
		wave.rotation = PI
	$Timer.set_wait_time(1)	
	
func se_asusta(instigator: Node2D):
	velocity = (global_position-instigator.global_position)* 0.5* speed
	
	
func _on_body_entered(body:Node2D):
	if body.is_in_group("player"):
		_target = body
func _on_body_exited(body:Node2D):
	if body.is_in_group("player"):
		_target = null

func _on_body_entered2(body:Node2D):
	_target2 = body
func _on_body_exited2(body:Node2D):
	_target2 = null
	
func _on_Timer_timeout():
	if _target2 != null:
		Scare()

func get_health():
	return health
	
func take_damage(damage):
	health -= damage
	print(get_health())
	if health<=0:
		die()
			
func die():
	queue_free()
	print("*c muere*")

func _on_HurtBox_area_entered(area):
	if area.is_in_group("trap"):
		damage=area.get_damage()
		insideTrap = true

func _on_HurtBox_area_exited(area):
	if area.is_in_group("trap"):
		damage=0
		insideTrap = false

extends KinematicBody2D

var linear_vel = Vector2.ZERO #Como obtengo la posicion del nodo¿?
var SPEED = 200
var Acceleration = 100
var health = 100
var velocity = Vector2()
onready var hurtbox = $Hurtbox
onready var anim_tree= $AnimationTree
onready var ray_cast = $RayCast2D
onready var playback = anim_tree.get("parameters/playback")
var SoundWave = preload("res://scenes/SoundWave.tscn")
onready var scare_spawn = $Pivot/ScareSpawn
onready var pivot=$Pivot

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_tree.active=true
	pass # Replace with function body.
	

func _physics_process(delta):
	#velocity = move_and_slide(velocity,Vector2.UP)
	#var move_input_x = Input.get_axis("left", "right")
	#var move_input_y = Input.get_axis("up", "down")
	#velocity.x = move_toward(velocity.x,move_input_x*SPEED,Acceleration)	
	#velocity.y = move_toward(velocity.y,move_input_y*SPEED,Acceleration)
	
	
	var target_velY = Input.get_action_strength("down") -   Input.get_action_strength("up")
	var target_velX = Input.get_action_strength("right") -  Input.get_action_strength("left")
	linear_vel.y = lerp(linear_vel.y, target_velY * SPEED, 0.5)
	linear_vel.x = lerp(linear_vel.x, target_velX * SPEED, 0.5)
	linear_vel = move_and_slide(linear_vel)
	
	#if Input.is_action_just_pressed("interact") and ray_cast.is_colliding():
	#	var collider = ray_cast.get_collider()
	#	if collider.has_method("interact"):
	#		collider.interact()
	#		print("is activated: ",collider.is_activated())
	
	if  Input.is_action_just_pressed("Boo"):
		Scare()
	#	playback.travel("Scare")
	

func Scare():
	var wave =SoundWave.instance()
	get_parent().add_child(wave)
	wave.global_position = scare_spawn.global_position
	if pivot.scale.x<0:
		wave.rotation = PI
		
func take_damage(damage):
	health -= damage

func get_health():
	return health

func _on_Hurtbox_area_entered(area):
	if area.is_in_group("enemy"):
		take_damage(area.get_damage())

extends KinematicBody2D

onready var hurtbox = $Hurtbox
onready var ray_cast = $RayCast2D
onready var anim_tree= $AnimationTree
onready var scare_spawn = $ScareSpawn
onready var playback = anim_tree.get("parameters/playback")

var linear_vel = Vector2.ZERO 
var SPEED = 200
var health = 100
var SoundWave = preload("res://scenes/SoundWave.tscn")

	
func _ready():
	anim_tree.active=true


func _physics_process(_delta):
	var target_velY = Input.get_action_strength("down") -   Input.get_action_strength("up")
	var target_velX = Input.get_action_strength("right") -  Input.get_action_strength("left")
	linear_vel.y = lerp(linear_vel.y, target_velY * SPEED, 0.5)
	linear_vel.x = lerp(linear_vel.x, target_velX * SPEED, 0.5)
	linear_vel = move_and_slide(linear_vel)
	
	if Input.is_action_just_pressed("interact") and ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		if collider.has_method("interact"):
			collider.interact()
			print("is activated: ",collider.is_activated())
	
	if  Input.is_action_just_pressed("Boo"):
		Scare()

func Scare():
	var wave =SoundWave.instance()
	get_parent().add_child(wave)
	wave.global_position = scare_spawn.global_position
	
func take_damage(damage):
	health -= damage

func get_health():
	return health

func _on_Hurtbox_area_entered(area):
	if area.is_in_group("enemy"):
		take_damage(area.get_damage())

extends KinematicBody2D
onready var botonE = $Interactuar
onready var hurtbox = $Hurtbox
onready var ray_cast = $RayCast2D
onready var anim_tree= $AnimationTree
onready var scare_spawn = $ScareSpawn
onready var playback = anim_tree.get("parameters/playback")

var linear_vel = Vector2.ZERO 
var SPEED = 350
var health = 100
var SoundWave = preload("res://scenes/SoundWave.tscn")
var inside = false 
var damage = 0
	
func _ready():
	anim_tree.active=true


func _physics_process(_delta):
	var target_velY = Input.get_action_strength("down") -   Input.get_action_strength("up")
	var target_velX = Input.get_action_strength("right") -  Input.get_action_strength("left")
	linear_vel.y = lerp(linear_vel.y, target_velY * SPEED, 0.5)
	linear_vel.x = lerp(linear_vel.x, target_velX * SPEED, 0.5)
	linear_vel = move_and_slide(linear_vel)
	
	if inside:
		take_damage(damage)
	
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		if collider.is_in_group("switch"):
			botonE.visible=true
			
		if Input.is_action_just_pressed("interact"):
			if collider.has_method("interact"):
				collider.interact()
				print("is activated: ",collider.is_activated())
	else:
		botonE.visible=false
		
	if  Input.is_action_just_pressed("Boo"):
		Scare()

func Scare():
	var wave =SoundWave.instance()
	get_parent().add_child(wave)
	wave.global_position = scare_spawn.global_position
	
func take_damage(damage):
	health -= damage
	if health<=0:
		game_over()

func get_health():
	return health

func _on_Hurtbox_area_entered(area):
	if area.is_in_group("enemy") or area.is_in_group("trap"):
		damage =area.get_damage()
		inside = true

func _on_Hurtbox_area_exited(area):
	if area.is_in_group("enemy") or area.is_in_group("trap"):
		damage = 0
		inside = false

func game_over():
	print("GG EZ MANCO QL, perdiste")

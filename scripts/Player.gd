extends KinematicBody2D

onready var hurtbox = $Hurtbox
onready var ray_cast = $RayCast2D
onready var anim_tree= $AnimationTree
onready var scare_spawn = $Pivot/ScareSpawn
onready var pivot = $Pivot
onready var playback = anim_tree.get("parameters/playback")
var velocity = Vector2()
var linear_vel = Vector2.ZERO 
var SPEED = 350
var ACCELERATION =100
var health = 100

export var scaring = false
var SoundWave = preload("res://scenes/SoundWave.tscn")

	
func _ready():
	scaring = false
	anim_tree.active=true


func _physics_process(_delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	var move_input_horizontal = Input.get_axis("left", "right")
	var move_input_vertical = Input.get_axis("up", "down")
	
	velocity.x = move_toward(velocity.x, move_input_horizontal * SPEED, ACCELERATION)
	velocity.y = move_toward(velocity.y, move_input_vertical * SPEED, ACCELERATION)
	
	if scaring:
		move_input_vertical = 0 
		move_input_horizontal = 0
	
	if Input.is_action_just_pressed("interact") and ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		if collider.has_method("interact"):
			collider.interact()
			print("is activated: ",collider.is_activated())
	
	if Input.is_action_pressed("right") and not Input.is_action_just_pressed("left"):
		pivot.scale.x = 1
	if Input.is_action_pressed("left") and not Input.is_action_just_pressed("right"):
		pivot.scale.x = -1
	
	
	if  Input.is_action_just_pressed("Boo"):
		Scare()

func Scare():
	var wave =SoundWave.instance()
	get_parent().add_child(wave)
	wave.global_position = scare_spawn.global_position
	if pivot.scale.x < 0:
		wave.rotation = PI
	
func take_damage(damage):
	health -= damage
	if health<=0:
		game_over()

func get_health():
	return health

func _on_Hurtbox_area_entered(area):
	if area.is_in_group("enemy") or area.is_in_group("trap"):
		take_damage(area.get_damage())

func game_over():
	print("GG EZ MANCO QL, perdiste")
	
func se_asusta(instigator: Node2D):
	var move_input_horizontal = (global_position-instigator.global_position).x
	velocity.x = move_toward(velocity.x, move_input_horizontal * SPEED, ACCELERATION*5)

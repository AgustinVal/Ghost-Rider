extends KinematicBody2D

onready var anim_tree = $AnimationTree
onready var playback = anim_tree.get("parameters/playback")

var SPEED = 200
var ACCELERATION = 500
var GRAVITY = 1
var timer = 0 #Para el movimiento del fantasma

var velocity = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	anim_tree.active = true
	
func take_damage(Node2D): #Cuando reciba daño por la luz
	pass


func _physics_process(delta):
	timer += delta * 4
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.y += GRAVITY * cos(timer) * 10


















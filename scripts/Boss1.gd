extends KinematicBody2D

onready var anim_tree = $AnimationTree
onready var playback = anim_tree.get("parameters/playback")

var SPEED = 200
var velocity = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	anim_tree.active = true


func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)


















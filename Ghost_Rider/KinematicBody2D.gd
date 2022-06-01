extends KinematicBody2D

onready var anim_tree= $AnimationTree
onready var playback = anim_tree.get("parameters/playback")

var speed =10
var acceleration= 200

var velocity=Vector2()

func _ready():
	anim_tree.active=true
	pass # Replace with function body.
	
func _physics_process(delta):
	pass#velocity= move_and_slide(velocity, Vector2.)

func se_asusta(instigator: Node2D):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

extends KinematicBody2D

onready var detection_area = $DetectionArea
onready var hurtbox=$HurtBox
var velocity = Vector2()
var SPEED = 100
var ACCELERATION = 500
var _target: Node2D = null
var health = 100
var damage = 0
var inside = false

func _ready():
	detection_area.connect("body_entered", self, "_on_body_entered")


func _physics_process(_delta):
	if inside:
		take_damage(damage)
	var move_inputX = 0
	var move_inputY = 0
	if _target:
		move_inputX = sign(_target.global_position.x - global_position.x)
		move_inputY = sign(_target.global_position.y - global_position.y)
	velocity.x = move_toward(velocity.x, move_inputX * SPEED, ACCELERATION)
	velocity.y = move_toward(velocity.y, move_inputY * SPEED, ACCELERATION) #+ GRAVITY * cos(timer)
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_body_entered(body: Node):
	_target = body
	
func take_damage(damage):
	health -= damage
	print(get_health())
	if health<=0:
		die()

func get_health():
	return health

func die():
	queue_free()
	print("*c muere*")
	
func _on_HurtBox_area_entered(area):
	if area.is_in_group("trap"):
		damage=area.get_damage()
		inside = true


func _on_HurtBox_area_exited(area):
	if area.is_in_group("trap"):
		damage=0
		inside = false

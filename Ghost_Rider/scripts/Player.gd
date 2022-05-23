extends KinematicBody2D

onready var hurtbox = $Hurtbox
onready var _animated_sprite = $AnimatedSprite

var linear_vel = Vector2.ZERO 
var SPEED = 200
var health = 100

	
func _ready():
	pass


func _process(_delta):
		_animated_sprite.stop()

func _physics_process(_delta):
	var target_velY = Input.get_action_strength("down") -   Input.get_action_strength("up")
	var target_velX = Input.get_action_strength("right") -  Input.get_action_strength("left")
	linear_vel.y = lerp(linear_vel.y, target_velY * SPEED, 0.5)
	linear_vel.x = lerp(linear_vel.x, target_velX * SPEED, 0.5)
	linear_vel = move_and_slide(linear_vel)
	
	if Input.is_action_just_pressed("interact") and $RayCast2D.is_colliding():
		var collider = $RayCast2D.get_collider()
		if collider.has_method("interact"):
			collider.interact()
			print("is activated: ",collider.is_activated())
	
func take_damage(damage):
	health -= damage

func get_health():
	return health

func _on_Hurtbox_area_entered(area):
	if area.is_in_group("enemy"):
		take_damage(area.get_damage())
	pass # Replace with function body.

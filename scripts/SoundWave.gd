extends Area2D


var SPEED = 350

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body: Node2D):
	if body.has_method("se_asusta"):
		body.se_asusta(self)
		queue_free()
	#queue_free()
	
func _physics_process(delta):
	position += SPEED * transform.x *delta

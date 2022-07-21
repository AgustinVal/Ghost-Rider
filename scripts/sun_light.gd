extends Area2D

onready var animated_sprite = $AnimatedSprite

export (float) var base_damage = 0.5
onready var damage = base_damage
 
export (NodePath) var lever_node
onready var lever = get_node(lever_node)

export var activated = true

func switch(activated):
	if activated:
		animated_sprite.playing = true
		damage = base_damage
	else:
		animated_sprite.playing = false
		$AnimatedSprite.frame = 3
		damage = 0
		
func _ready():
	lever.connect("interaction", self, "_on_interaction")
	switch(activated)
	animated_sprite.set_modulate(Color(1-base_damage,1-base_damage*0.5,1,1))

func get_damage():
	return damage

func _on_interaction():
	activated = not activated
	switch(activated)

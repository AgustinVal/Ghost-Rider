extends Area2D

onready var animated_sprite = $AnimatedSprite

export (float) var base_damage = 0.1
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
	var x = damage
	lever.connect("interaction", self, "_on_interaction")
	switch(activated)
	animated_sprite.set_modulate(Color(x,0.8,0.05,0.7))

func get_damage():
	return damage

func _on_interaction():
	activated = not activated
	switch(activated)

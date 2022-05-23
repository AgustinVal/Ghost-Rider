extends Area2D

onready var animated_sprite = $AnimatedSprite

export (int) var base_damage = 20
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

func get_damage():
	return damage

func _on_interaction():
	activated = not activated
	switch(activated)

extends MarginContainer


onready var play = $VBoxContainer/Play
onready var exit = $VBoxContainer/Exit


# Called when the node enters the scene tree for the first time.
func _ready():
	play.connect("pressed", self, "_on_Play_pressed")
	exit.connect("pressed", self, "_on_Exit_pressed")




func _on_Play_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")


func _on_Exit_pressed():
	get_tree().quit()

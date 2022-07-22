extends MarginContainer


onready var play = $VBoxContainer/Play
onready var exit = $VBoxContainer/Exit
onready var credits = $VBoxContainer/Credits



# Called when the node enters the scene tree for the first time.
func _ready():
	play.connect("pressed", self, "_on_Play_pressed")
	exit.connect("pressed", self, "_on_Exit_pressed")
	credits.connect("pressed", self, "_on_credits_pressed")




func _on_Play_pressed():
	get_tree().change_scene("res://scenes/Tutorial.tscn")

func _on_credits_pressed():
	get_tree().change_scene("res://scenes/GodotCredits.tscn")


func _on_Exit_pressed():
	get_tree().quit()

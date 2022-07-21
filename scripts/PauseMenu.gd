extends MarginContainer
onready var resume = $PanelContainer/VBoxContainer/resume
onready var main_menu = $PanelContainer/VBoxContainer/main_menu
 
func _ready():
	resume.connect("pressed",self,"_on_resume_pressed")
	main_menu.connect("pressed",self,"_on_main_menu_pressed")
	visible = false
	
func _input(event):
	if event.is_action_pressed("pause") and not event.is_echo():
		if visible:
			get_tree().paused = false
			visible = false
		else:
			get_tree().paused = true
			visible = true
		
func _on_resume_pressed():
	get_tree().paused=false
	visible = false
	
func _on_main_menu_pressed():
	get_tree().paused=false
	visible = false
	get_tree().change_scene("res://scenes/MainMenu.tscn")
	


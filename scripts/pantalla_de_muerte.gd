extends MarginContainer
onready var main_menu = $PanelContainer/VBoxContainer/MainMenu

export (NodePath) var player_node
onready var player = get_node(player_node)

func _ready():
	visible = false
	main_menu.connect("pressed",self,"_on_main_menu_pressed")

func _process(delta):
	if player.get_health()<=0:
		get_tree().paused = true
		visible = true
	
func _on_main_menu_pressed():
	get_tree().paused=false
	visible = false
	get_tree().change_scene("res://scenes/MainMenu.tscn")

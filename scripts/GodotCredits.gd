###Codigo de Ben Bishop: https://github.com/benbishopnz/godot-credits
###Editado por 4Tercios para el proyecto "Ghost Raider"
extends Node2D

const section_time := 2.0
const line_time := 0.3
const base_speed := 100
const speed_up_multiplier := 10.0
const title_color := Color.blueviolet

var scroll_speed := base_speed
var speed_up := false

onready var line := $CreditsContainer/Line
var started := false
var finished := false

var section
var section_next := true
var section_timer := 0.0
var line_timer := 0.0
var curr_line := 0
var lines := []

var credits = [
	[
		"A game by 4Tercios Group"
	],[
		"Programming",
		"Agustín Valenzuela A.",
		"Bastian Reyes",
		"Leonel Espinoza S.",
		"Ben Bishop"
	],[
		"Art",
		"Bastian Reyes",
		"NYKNCK (@nyk_nck)",#https://nyknck.itch.io/staranimation
		"Gerald Burke",#https://gerald-burke.itch.io/geralds-keys
		"Stealthix",#https://stealthix.itch.io/32-x-32-dungeon-assets
		"Estúdio Vaca Roxa",#https://bakudas.itch.io/generic-dungeon-pack
		"Mack",#https://gdu.one/forums/gallery/image/5338-tilee/	
		"Luis Eduardo",#https://discord.com/channels/951926082993524787/953006744148246629/999861317756272721
		"Jacob Coher",#https://ar.pinterest.com/pin/557179785141639685/
		"Nicnubill",#https://www.deviantart.com/nicnubill/art/Fancy-wooden-furniture-391233794
		"Ayene-chan"#https://www.deviantart.com/ayene-chan/art/RPG-Maker-VX-Ace-VX-like-XP-Tile-472063464
	],[
		"Music",
		"DL Sounds: Retro Gap Loop"#https://www.dl-sounds.com/royalty-free/retro-gap-loop/
	],[
		"Tools used",
		"Developed with Godot Engine",
		"https://godotengine.org/license",
		"",
		"Art created with Piskel",
		"https://www.piskelapp.com/terms"
	],[
		"Special thanks",
		"CC5408-2"
	]
]


func _process(delta):
	var scroll_speed = base_speed * delta
	
	if section_next:
		section_timer += delta * speed_up_multiplier if speed_up else delta
		if section_timer >= section_time:
			section_timer -= section_time
			
			if credits.size() > 0:
				started = true
				section = credits.pop_front()
				curr_line = 0
				add_line()
	
	else:
		line_timer += delta * speed_up_multiplier if speed_up else delta
		if line_timer >= line_time:
			line_timer -= line_time
			add_line()
	
	if speed_up:
		scroll_speed *= speed_up_multiplier
	
	if lines.size() > 0:
		for l in lines:
			l.rect_position.y -= scroll_speed
			if l.rect_position.y < -l.get_line_height():
				lines.erase(l)
				l.queue_free()
	elif started:
		finish()


func finish():
	if not finished:
		finished = true
		get_tree().change_scene("res://scenes/MainMenu.tscn")
		# NOTE: This is called when the credits finish
		# - Hook up your code to return to the relevant scene here, eg...
		#get_tree().change_scene("res://scenes/MainMenu.tscn")


func add_line():
	var new_line = line.duplicate()
	new_line.text = section.pop_front()
	lines.append(new_line)
	if curr_line == 0:
		new_line.add_color_override("font_color", title_color)
	$CreditsContainer.add_child(new_line)
	
	if section.size() > 0:
		curr_line += 1
		section_next = false
	else:
		section_next = true


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		finish()
	if event.is_action_pressed("ui_down") and !event.is_echo():
		speed_up = true
	if event.is_action_released("ui_down") and !event.is_echo():
		speed_up = false

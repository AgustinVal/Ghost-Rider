extends Node2D

func _ready():
	$AreaInicio.connect("body_entered",self,"_play_animation")

func _play_animation(body):
	$AreaInicio.disconnect("body_entered",self,"_play_animation")
	$AnimationPlayer.play("Show")

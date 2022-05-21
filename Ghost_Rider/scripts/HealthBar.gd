extends CanvasLayer

export (NodePath) var player_node
onready var player = get_node(player_node)

func _process(_delta):
	print(player)
	$TextureProgress.value = player.get_health()
	

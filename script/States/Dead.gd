extends State
class_name DeadState

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_parent()
	#player.change_anim("Idle")
	player.velocity.x = 0
	player.velocity.y = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

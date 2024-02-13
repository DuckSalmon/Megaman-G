extends State
class_name HitState

var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_parent()
	#player.change_anim("Idle")
	player.velocity.x = 0
	player.velocity.y = 0
	player.change_anim("damage")
	await get_tree().create_timer(0.3).timeout
	player.change_anim("idle")
	get_parent().change_state("Idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

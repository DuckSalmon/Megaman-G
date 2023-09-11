extends CanvasLayer

@onready var player = %Player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = str(Global.projectile_max_number) + "XY" + str(Global.playerxy)
	#$Label.text = "SPEED:" + str(player.velocity.y) + "press time:" + str(player.left_right_key_press_time) + str(Global.projectile_max_number)

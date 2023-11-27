extends Area2D

var speed = 300
var direction := Vector2(1, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	direction.x = Global.player_dir
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(speed*delta*direction)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


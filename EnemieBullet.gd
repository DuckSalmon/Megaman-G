extends Area2D

var damage := 2
var speed = 200
var direction := Vector2(1, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(speed*delta*direction)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(player):
	player.damage(damage)

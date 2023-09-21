extends Sprite2D

var speed := 60
var direction := Vector2i(1,0) 

# Called when the node enters the scene tree for the first time.
func _ready():
	self.position = Global.playerxy
	$Anim.play("Explosion")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(direction * speed * delta)
	


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

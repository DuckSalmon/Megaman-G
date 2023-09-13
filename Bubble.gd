extends Area2D

var speed = 35

func _ready():
	$Sprite2D/AnimationPlayer.play("bubble")
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(speed*delta*Vector2(0,-1))



func _on_body_exited(body):
	queue_free()


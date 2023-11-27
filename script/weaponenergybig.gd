extends CharacterBody2D

var points := 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_on_floor:
		velocity.y += 50

	move_and_slide()

func _on_area_2d_body_entered(player):
	#Effect_manager.heal(health)
	queue_free()

func timer():
	$Timer.start()

func _on_timer_timeout():
	queue_free()

extends Area2D

var health = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health == 0:
		queue_free()


func _on_area_entered(body):
	print("hit")
	health -= 1
	%SFXplayer2.play()
	body.queue_free()
	Global.projectile_max_number += 1


func _on_visible_on_screen_notifier_2d_screen_exited():
	pass

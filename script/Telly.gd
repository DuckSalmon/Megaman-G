extends CharacterBody2D


var speed := 20
var health := 1
var damage := 2

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.play() # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#global_position = position.move_toward(Global.playerxy, delta * speed)
	
	velocity = global_position.direction_to(Global.playerxy) * speed
	
	
	if health == 0:
		destroyied()
	
	move_and_slide()
	
func destroyied():
	speed = 0
	var pos = self.global_position
	Effect_manager.explosion(pos)
	queue_free()


func _on_area_2d_area_entered(area):
	health -= 1
	Audio.damagesfx()
	area.queue_free()


func _on_area_2d_body_entered(player):
	player.damage(damage)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

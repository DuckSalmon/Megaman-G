extends CharacterBody2D

var health := 3
var speed := 32
@export_enum("Left:-1", "Right:1") var direction: int #0 left 1 right

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.play()
	print(direction)
	$RayCast2D.target_position.x *= direction


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#Defeated
	if health == 0:
		$Sprite.hide()
		$Explosion.show()
		$Explosion.play()
		
		#queue_free()

	#Add gravity
	if not is_on_floor():
		velocity.y += 50

	#Movement and anims
	if direction == 1:
		velocity.x = speed 
		$RayCast2D.target_position.x = 16
		$Sprite.flip_h = true
	else:
		velocity.x = -speed
		$RayCast2D.target_position.x = -16
		$Sprite.flip_h = false
	
	#Change direction when colliding
	if $RayCast2D.is_colliding():
		$RayCast2D.target_position.x *= -1
		direction *= -1
	
	#Change position toward player
	if Global.playerxy.x < self.global_position.x and direction == -1:
		$ChangeDirectionTimer.start()
	if Global.playerxy.x > self.global_position.x and direction == 1:
		$ChangeDirectionTimer.start()

	move_and_slide()

func _on_visible_on_screen_notifier_2d_screen_exited():
	pass

func _on_area_2d_area_entered(area):
	print("hit")
	health -= 1
	%SFXplayer2.play()
	area.queue_free()
	Global.projectile_max_number += 1

func _on_change_direction_timer_timeout():
	direction *= -1


func _on_explosion_effect_animation_finished():
	queue_free()

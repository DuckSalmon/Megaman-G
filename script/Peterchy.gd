extends CharacterBody2D
class_name Enemie
var health := 3
var speed := 32
var damage := 4
var direction: int = 1 


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.play()
	$RayCast2D.target_position.x *= direction
	if Global.playerxy.x < self.global_position.x and direction == 1:
		direction *= -1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#$Label.text = str($ChangeDirectionTimer.time_left)
	#Defeating
	if health == 0:
		destroyied()

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

#Node deleted when exit from screen
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_2d_area_entered(area):
	health -= 1
	Audio.damagesfx()
	area.queue_free()
	$Sprite/HitAnim.play("hit")
	
func _on_change_direction_timer_timeout():
	direction *= -1

func _on_area_2d_body_entered(player):
	player.damage(damage)

func destroyied():
	speed = 0
	var pos = self.global_position
	Effect_manager.explosion(pos)
	queue_free()

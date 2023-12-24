extends CharacterBody2D

var health := 1
var isinvincible := true
var is_active := false
var damage := 4
var direction := -1
const SPEED = 100.0
var pos = Vector2.ZERO

@onready var BULLET = preload("res://EnemieBullet.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	var proximity = self.global_position.x - Global.playerxy.x
	
	if is_active == false and abs(proximity) < 50 :
		is_active = true
		$Timer.start()

	#$Label.text = str(pos)#$Timer.time_left)

	
	if health <= 0:
		var pos = self.global_position
		Effect_manager.explosion(pos)
		queue_free()
	
	pos = global_position
	
	move_and_slide()

#func timer():
	##randomize time?
	#
	##print("culo")
	#pass

func _on_area_2d_area_entered(area):
	if isinvincible == true:
		Audio.reflsfx()
		area.direction.x *= -1
		area.direction.y = -1
	else:
		health -= 1
		Audio.damagesfx()
		area.queue_free()


func _on_area_2d_body_entered(player):
	player.damage(damage)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_timer_timeout():
	#shoot
	var proximity2 = self.global_position.x - Global.playerxy.x
	$Sprite2D/AnimationPlayer.play("attack")
	isinvincible = false
	if  proximity2 <= 0 and direction == -1:
		direction *= -1
		$Sprite2D.flip_h = true
	if proximity2 >= 0 and direction == 1:
		direction *= -1
		$Sprite2D.flip_h = false
	else:
		pass

func _on_animation_player_animation_finished(attack):
	isinvincible = true
	$Sprite2D/AnimationPlayer.play("idle")
	is_active = false
	velocity.x = 0
	
func move():
	velocity.x = SPEED*direction

func shoot():
	var a = BULLET.instantiate()
	get_parent().add_child(a)
	a.global_position = pos
	a.speed = 120
	a.direction.x *= direction
	var b = BULLET.instantiate()
	get_parent().add_child(b)
	b.global_position = pos
	b.speed = 120
	b.direction.x *= direction
	b.direction.y = -0.5
	var c = BULLET.instantiate()
	get_parent().add_child(c)
	c.global_position = pos
	c.speed = 120
	c.direction.x *= direction
	c.direction.y = 0.5
	

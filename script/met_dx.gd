extends CharacterBody2D

var health := 1
var isinvincible := true
var damage := 4
var direction :bool = 0
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	move_and_slide()

func shoot():
	#move to player change dir, shoot and walk to player
	#if Global.playerxy.x < self.global_position.x:
		#$AnimatedSprite2D.scale.x = 1
	#else:
		#$AnimatedSprite2D.scale.x = -1
	pass

func _on_area_2d_area_entered(area):
	if isinvincible == true:
		Audio.reflsfx()
		area.direction.x *= -1
		area.direction.y = -1
	else:
		health -= 1
		area.queue_free()


func _on_area_2d_body_entered(player):
	player.damage(damage)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

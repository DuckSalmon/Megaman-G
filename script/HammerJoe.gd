extends Area2D

var health := 8
var damage := 4
var isinvincible := true
var isleftfacing := true

@onready var HAMMER = preload("res://animated_bullet.tscn")

func _ready():
	main()
	
	
	

func _physics_process(delta):
	if Global.playerxy.x < self.global_position.x:
		scale.x = 1
		isleftfacing = true
	else:
		scale.x = -1
		isleftfacing = false
	
	if health == 0:
		destroyied()
	
func main():
	$Sprite2D/AnimationPlayer.play("load")
	$Timer.wait_time = 1
	$Timer.start()
	isinvincible = true
	

func _on_area_entered(area):
	if isinvincible == true:
		Audio.reflsfx()
		area.direction.x *= -1
		area.direction.y = -1
	else:
		health -= 1
		Audio.damagesfx()
		area.queue_free()
		$Sprite2D/HitAnim.play("hit")

func _on_body_entered(player):
	player.damage(damage)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_timer_timeout():
	$Sprite2D/AnimationPlayer.play("aim")
	$Timeraim.start()
	isinvincible = false

func _on_timeraim_timeout():
	$Sprite2D/AnimationPlayer.play("shoot")
	var a = HAMMER.instantiate()
	get_parent().add_child(a)
	if isleftfacing == true:
		a.position = Vector2(-8,0)
		a.direction.x = -1
	else:
		a.mirrored = true
		a.direction.x = 1
		a.position = Vector2(10 , 0)


func _on_animation_player_animation_finished(shoot):
	main()

func destroyied():
	var pos = self.global_position
	Effect_manager.explosion(pos)
	queue_free()

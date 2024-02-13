extends State
class_name WalkingState

var player
var anim
var JUMP_SPEED = 285.0
var left_right_key_press_time: float = 0
var timer
var is_shooting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	add_child(timer)
	player = get_parent().get_parent()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#gravity
	if not player.is_on_floor():
		get_parent().change_state("Onair")
	
	left_right_key_press_time += 60 * delta
	
	#Actions
	#Movements
	if is_shooting == false:
		if Input.is_action_pressed("right"):
			player.direction = 1#Input.get_axis("left", "right")
			player.velocity.x =  player.WALK_SPEED
			if left_right_key_press_time < 7: #max toe tipping frames
				player.change_anim("Tipping")
			else:
				player.change_anim("walk")
	
		elif Input.is_action_pressed("left"):
			player.direction = -1
			player.velocity.x = -1 * player.WALK_SPEED
			if left_right_key_press_time < 7: #max toe tipping frames
				player.change_anim("Tipping")
			else:
				player.change_anim("walk")
		else:
			get_parent().change_state("Idle")

#SHOOT
	if Input.is_action_just_pressed("shoot"):
		is_shooting = true
		player.change_anim("shoot_walk")
		timer.wait_time = 0.25
		timer.one_shot = true
		timer.start()
		timer.timeout.connect(_on_timer_timeout)
		player.shoot()
		
#Jump
	if Input.is_action_just_pressed("jump"):
		player.is_rising = true
		player.velocity.y = -JUMP_SPEED * 1.0
		get_parent().change_state("Onair")

func _on_timer_timeout():
	player.change_anim("walk")
	is_shooting = false

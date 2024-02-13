extends State
class_name IdleState

var player
var JUMP_SPEED = 285.0
var timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	add_child(timer)
	player = get_parent().get_parent()
	player.change_anim("Idle")
	player.velocity.x = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#gravity
	if not player.is_on_floor():
		get_parent().change_state("Onair")
	
	#Actions
	#Walk
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		get_parent().change_state("Walking")
	
	#SHOOT
	if Input.is_action_just_pressed("shoot"):
		player.change_anim("shoot_idle")
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
	player.change_anim("Idle")

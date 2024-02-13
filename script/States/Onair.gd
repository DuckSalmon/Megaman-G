extends State
class_name OnairState

var player
var MAX_FALL_SPEED := 420.0
var timer

@onready var landsfx = preload("res://assets/AUDIO/SFX/Landing.wav")


func _ready():
	timer = Timer.new()
	add_child(timer)
	player = get_parent().get_parent()
	player.change_anim("jump")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#gravity
	player.velocity.y = clamp(player.velocity.y + 15.0, -MAX_FALL_SPEED, MAX_FALL_SPEED)
	if player.velocity.y > MAX_FALL_SPEED: #Limits fall speeds
		player.velocity.y = MAX_FALL_SPEED
	if player.is_on_floor():
		Audio.playsfx(landsfx)
		get_parent().change_state("Idle")
	
	#Actions
	#Air Movements
	if Input.is_action_pressed("right") or Input.is_action_pressed("left"):
		var direction = Input.get_axis("left", "right")
		player.direction = direction
		player.velocity.x = direction * player.WALK_SPEED
		
	else:
		player.velocity.x = 0
	
	if Input.is_action_just_released("jump") and player.is_rising == true:
		player.velocity.y = 5
		player.is_rising = false
	
	#SHOOT
	if Input.is_action_just_pressed("shoot"):
		player.change_anim("shoot_jump")
		timer.wait_time = 0.25
		timer.one_shot = true
		timer.start()
		timer.timeout.connect(_on_timer_timeout)
		player.shoot()

func _on_timer_timeout():
	player.change_anim("jump")
	

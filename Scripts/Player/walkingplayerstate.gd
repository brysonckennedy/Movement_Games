class_name WalkingPlayerState
extends PlayerState


var input_direction: Vector2
var move_direction: Vector3


func process_physics(delta : float) -> void:
	super(delta)
	
	input_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	if(Global.player.velocity.length() == 0 && !isExiting): #this needs to be changed. flips between idle and walking because velocity doesnt change before this
		next_state = "IdlePlayerState"
		exit()
	
	move_direction = (Global.player.yaw_pivot.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()
	
	if move_direction:
		Global.player.velocity.x = lerp(Global.player.velocity.x, Global.player.SPEED * move_direction.x, Global.player.ACCELERATION)
		Global.player.velocity.z = lerp(Global.player.velocity.z, Global.player.SPEED * move_direction.z, Global.player.ACCELERATION)
	elif(Global.player.velocity.length() > 5.0):
		Global.player.velocity.x = move_toward(Global.player.velocity.x, 0, Global.player.SPRINT_DECELERATION)
		Global.player.velocity.z = move_toward(Global.player.velocity.z, 0, Global.player.SPRINT_DECELERATION)
	else:#maybe do a check if speed is over walking_speed slow down faster
		Global.player.velocity.x = move_toward(Global.player.velocity.x, 0, Global.player.DECELERATION)
		Global.player.velocity.z = move_toward(Global.player.velocity.z, 0, Global.player.DECELERATION)
	
	Global.player.velocity.y -= Global.player.GRAVITY * delta
	
	Global.player.move_and_slide()


func process_input(event : InputEvent) -> void:
	super(event)
	if(event.is_action_pressed("crouch") && !isExiting):
		if(Global.player.velocity.length() <= 5.0): #later do else: slide
			next_state = "CrouchingPlayerState"
			exit()
	
	if(event.is_action_pressed("sprint") && !isExiting):
		next_state = "SprintingPlayerState"
		exit()
		
	if(event.is_action_pressed("jump") && !isExiting):
		next_state = "JumpingPlayerState"
		exit()

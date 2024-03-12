class_name IdlePlayerState
extends PlayerState


func process_physics(delta : float) -> void:
	super(delta)
	#gravity on player
	if(Global.player.velocity.y < 0  && !isExiting):
		next_state = "FallingPlayerState"
		exit()
	if ((Input.is_action_pressed("move_forward") or
		Input.is_action_pressed("move_backward") or
		Input.is_action_pressed("move_right") or 
		Input.is_action_pressed("move_left"))  && !isExiting):
			if(Input.is_action_pressed("sprint")):
				next_state = "SprintingPlayerState"
				exit()
			else:
				next_state = "WalkingPlayerState"
				exit()
	
	Global.player.velocity.y -= Global.player.GRAVITY * delta
	
	Global.player.move_and_slide()


func process_input(event : InputEvent) -> void:
	super(event)
	if(event.is_action_pressed("crouch") && !isExiting):
		next_state = "CrouchingPlayerState"
		exit()
	
	if(event.is_action_pressed("jump") && !isExiting):
		next_state = "JumpingPlayerState"
		exit()

class_name IdlePlayerState
extends PlayerState


func process_physics(delta : float) -> void:
	super(delta)
	#gravity on player
	if(Global.player.velocity.y < 0):
		transition_state.emit("FallingPlayerState")
	if (Input.is_action_pressed("move_forward") or
		Input.is_action_pressed("move_backward") or
		Input.is_action_pressed("move_right") or 
		Input.is_action_pressed("move_left")):
			if(Input.is_action_pressed("sprint")):
				transition_state.emit("SprintingPlayerState")
			else:
				transition_state.emit("WalkingPlayerState")
	
	Global.player.velocity.y -= Global.player.GRAVITY * delta
	
	Global.player.move_and_slide()

func process_input(event : InputEvent) -> void:
	super(event)
	if(event.is_action_pressed("crouch")):
		transition_state.emit("CrouchingPlayerState")
	
	if(event.is_action_pressed("jump")):
		transition_state.emit("JumpingPlayerState")

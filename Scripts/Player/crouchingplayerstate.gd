class_name CrouchingPlayerState
extends PlayerState


var input_direction: Vector2
var move_direction: Vector3

func enter() -> void:
	super()
	Global.player.animation_player.play("Crouch", -1, Global.player.CROUCH_ANIMATION_SPEED)

func exit() -> void:
	super()
	Global.player.animation_player.play("Crouch", -1, -Global.player.CROUCH_ANIMATION_SPEED, true)

func process_physics(delta: float) -> void:
	super(delta)
	
	if(Input.get_action_raw_strength("crouch") == 0): #&& Global.player.crouch_shapecast.is_colliding() == false):
		transition_state.emit("IdlePlayerState")

	input_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	move_direction = (Global.player.yaw_pivot.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()
	
	if move_direction:
		Global.player.velocity.x = lerp(Global.player.velocity.x, Global.player.CROUCH_SPEED * move_direction.x, Global.player.ACCELERATION)
		Global.player.velocity.z = lerp(Global.player.velocity.z, Global.player.CROUCH_SPEED * move_direction.z, Global.player.ACCELERATION)
	else:
		Global.player.velocity.x = move_toward(Global.player.velocity.x, 0, Global.player.DECELERATION)
		Global.player.velocity.z = move_toward(Global.player.velocity.z, 0, Global.player.DECELERATION)
	
	Global.player.velocity.y -= Global.player.GRAVITY * delta
	
	Global.player.move_and_slide()

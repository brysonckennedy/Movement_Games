class_name PlayerState
extends State


var yaw_input : float = 0.0
var pitch_input : float = 0.0


func process_input(event : InputEvent) -> void:
	if event is InputEventMouseMotion:
		if(Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED):
			yaw_input = -event.relative.x * Global.player.SENSITIVITY
			pitch_input = -event.relative.y * Global.player.SENSITIVITY


func process_physics(delta : float) -> void:
	Global.player.yaw_pivot.rotate_y(yaw_input * delta)
	Global.player.pitch_pivot.rotate_x(pitch_input * delta)
	Global.player.pitch_pivot.rotation.x = clamp(Global.player.pitch_pivot.rotation.x, -1.57, 1.57)
	yaw_input = 0.0
	pitch_input = 0.0
	
	if (Input.is_action_pressed("fire_weapon")):
		Global.player.rocket_launcher._PrimaryFire()

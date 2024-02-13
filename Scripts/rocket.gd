class_name Rocket
extends RigidBody3D

var rocket_direction : Vector3
var ROCKET_SPEED : float = 0.2
var ROCKET_ACCELERATION : float = 5.0

func _physics_process(delta : float) -> void:
	rocket_direction = Global.player.pitch_pivot.basis * Vector3(0, 0, -1)
	apply_force(ROCKET_SPEED * rocket_direction)

func _on_body_entered(body):
	queue_free()

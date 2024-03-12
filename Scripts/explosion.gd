extends Area3D

@onready var _Particles = $Particles

var Position: Vector3
var Impact = 10


func _ready() -> void:
	_Particles.emitting = true
	


func _on_timer_timeout():
	queue_free()


func _on_body_entered(body):
	Position = get_global_transform().origin
	if body == Global.player:
		#Global.player.rocket_hit(Position, Impact)
		print("hit player")
	else:
		push_warning("Body is not Player")

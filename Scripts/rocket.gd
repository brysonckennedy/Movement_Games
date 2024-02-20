extends RigidBody3D

@onready var _Particles = $Particles

var Explosion = preload("res://Scenes/Weapons/explosion.tscn")

func _ready() -> void:
	_Particles.emitting = true


func _on_body_entered(body):
	var W = get_tree().get_root()
	var E = Explosion.instantiate()
	E.set_global_transform(get_global_transform())
	W.add_child(E)
	queue_free()

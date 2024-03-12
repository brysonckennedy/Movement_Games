extends Node3D

@onready var RocketPoint = $RocketPoint
@onready var _Camera = get_viewport().get_camera_3d()
@onready var _Viewport = get_viewport().get_size()

@export var RocketSpeed : float = 80.0

var Rocket = preload("res://Scenes/Weapons/rocket.tscn")


func _PrimaryFire():
	var Target = GetCameraCollision()
	var RocketDirection = (Target - RocketPoint.global_transform.origin).normalized()
	SpawnRocket(RocketDirection)


func GetCameraCollision():
	var RayOrigin = _Camera.project_ray_origin(_Viewport/2)
	var RayEnd = (RayOrigin + _Camera.project_ray_normal(_Viewport/2) * 500)
	var params = PhysicsRayQueryParameters3D.new()
	params.from = RayOrigin
	params.to = RayEnd
	params.exclude = []
	
	var Intersection = get_world_3d().direct_space_state.intersect_ray(params)
	
	if not Intersection.is_empty():
		var ColPoint = Intersection.position
		return ColPoint
	else:
		return RayEnd


func SpawnRocket(Dir : Vector3):
	var W = get_tree().get_root()
	var R = Rocket.instantiate()
	W.add_child(R)
	
	R.set_global_position(RocketPoint.get_global_position())
	R.set_linear_velocity(Dir*RocketSpeed)

class_name Player
extends CharacterBody3D

@onready var player_state_machine : StateMachine = $PlayerStateMachine
@onready var yaw_pivot : Node3D = $YawPivot
@onready var pitch_pivot : Node3D = $YawPivot/PitchPivot
@onready var camera : Node3D = $YawPivot/PitchPivot/Camera3D

@export var SPEED : float = 5.0
@export var JUMP_FORCE : float = 5.0
@export var GRAVITY : float = 10
@export var SENSITIVITY : float = 0.2


func _ready() -> void:
	Global.player = self
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	player_state_machine.init()

func _unhandled_input(event: InputEvent) -> void:
	player_state_machine.process_input(event)

func _process(delta : float) -> void:
	player_state_machine.process_frame(delta)

func _physics_process(delta : float) -> void:
	player_state_machine.process_physics(delta)

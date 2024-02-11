class_name State
extends Node


signal transition_state(new_state_name: StringName)

func enter() -> void:
	pass

func exit() -> void:
	pass

func process_input(event : InputEvent) -> void:
	pass

func process_frame(delta : float) -> void:
	pass

func process_physics(delta : float) -> void:
	pass

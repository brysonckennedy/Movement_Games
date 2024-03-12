class_name State
extends Node


var animation_player : AnimationPlayer
var next_state : StringName
var isExiting : bool
@export var enter_animation : StringName
@export var exit_animation : StringName
signal transition_state(new_state_name: StringName)

func enter() -> void: #plays animation on enter
	print("entering " + self.name)
	animation_player.animation_finished.connect(finished_exit_animation)
	isExiting = false


func exit() -> void: #plays animation on exit
	print("exiting " + self.name)
	isExiting = true
	if(!exit_animation):
		print("no exit animation")
		isExiting = false
		animation_player.animation_finished.disconnect(finished_exit_animation)
		transition_state.emit(next_state)


func finished_exit_animation(anim_name : StringName) -> void:
	print(anim_name)
	print("animation done")
	animation_player.clear_queue()
	animation_player.clear_caches()
	if(isExiting):
		isExiting = false
		animation_player.animation_finished.disconnect(finished_exit_animation)
		transition_state.emit(next_state)


func process_input(event : InputEvent) -> void:
	pass


func process_frame(delta : float) -> void:
	pass


func process_physics(delta : float) -> void:
	pass

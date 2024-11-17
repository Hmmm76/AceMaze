extends Control


func _on_quit_pressed() -> void:
	get_tree().quit()



func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu/options_menu.tscn")



func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu/subject_menu.tscn")


func _on_back_2_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu/menu.tscn")

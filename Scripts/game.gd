extends Node2D

@onready var texture_rect: TextureRect = $TextureRect
@onready var cenario: Sprite2D = $Cenario

var all_characters := [
	preload("res://Personagens/cidadao1.jpg"),
	preload("res://Personagens/cidadao2.jpg"),
	preload("res://Personagens/Cangaceiro1.jpg"),
	preload("res://Personagens/Cangaceiro2.jpg")
]

var round_characters: Array = []
var current_round := 0
var infected_total := 0
var infected_killed := 0
var is_current_infected := false
var shader_material: ShaderMaterial

func _ready() -> void:
	texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	texture_rect.size = Vector2(300, 500)
	texture_rect.position = Vector2(450, 40)
	shader_material = ShaderMaterial.new()
	var grayscale = ShaderMaterial.new()
	grayscale.shader = preload("res://Scripts/grayscale.gdshader")
	shader_material.shader = preload("res://Scripts/grayscale.gdshader")
	cenario.material = grayscale
	texture_rect.material = shader_material
	round_characters = all_characters
	round_characters.shuffle()

	next_character()

func next_character() -> void:
	if round_characters.is_empty():
		end_game()
		return
	texture_rect.texture = round_characters.pop_back()
	is_current_infected = randf() < 0.5
	shader_material.set_shader_parameter("infected", is_current_infected)
	if is_current_infected:
		infected_total += 1

func _on_btn_kill_button_up() -> void:
	if is_current_infected:
		infected_killed += 1
	next_character()

func _on_btn_save_button_up() -> void:
	next_character()

func end_game() -> void:
	GameState.last_result_won = (infected_killed == infected_total)
	get_tree().change_scene_to_file("res://Cenas/day_end.tscn")

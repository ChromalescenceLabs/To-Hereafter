extends Control

var optionsButtonsAmb : PackedScene = preload("uid://etxrw1xsmd7f")
var optionsButtonsCourage: PackedScene = preload("uid://cnqomw0enool4")
var optionsButtonsComp: PackedScene = preload("uid://dnw2bv5aebpyx")
var resource = load("uid://e4mi38vfwerr")
var q_num = 0

var amb_num = 0
var comp_num = 0
var cour_num = 0

var last_soul

@onready var Terminus = $Terminus
@onready var OptionsContainer = $OptionsContainer

@onready var Q1 = $OptionsContainer/Q1
@onready var Q2 = $OptionsContainer/Q2
@onready var Q3 = $OptionsContainer/Q3
@onready var Q4 = $OptionsContainer/Q4
@onready var Q5 = $OptionsContainer/Q5
@onready var questions = [Q1, Q2, Q3, Q4, Q5] 

func _ready() -> void:
	set_process(false)
	OptionsContainer.visible = false
	Terminus.visible = true
	
	await get_tree().create_timer(1.0).timeout
	
	DialogueManager.show_dialogue_balloon(resource, "start")
	
	await DialogueManager.dialogue_ended
	
	create_tween().tween_property(Music.ExpoDumpMusic, "volume_db", -90.0, 5)
	
	DialogueManager.show_dialogue_balloon(resource, "spoopy")
	
	await DialogueManager.dialogue_ended
	
	Terminus.visible = false
	
	await get_tree().create_timer(1.5).timeout
	
	OptionsContainer.visible = true
	
	Music.ExpoDumpMusic.stop()
	Music.PersonalityTest.play()
	set_process(true)
	
func _process(_delta: float) -> void:
	if q_num != 5:
		if not OptionsContainer.get_child_count() == 9:
			personality_test()
	else:
		set_process(false)
		OptionsContainer.visible = false
		personality_tally()

func personality_test():
	questions[q_num].visible = true
	var optionsAmb = optionsButtonsAmb.instantiate()
	var optionsCourage = optionsButtonsCourage.instantiate()
	var optionsComp = optionsButtonsComp.instantiate()
	optionsAmb.q_num = q_num
	optionsCourage.q_num = q_num
	optionsComp.q_num = q_num
	var q_buttons = [optionsAmb, optionsCourage, optionsComp]
	
	while not q_buttons.is_empty():
		var randomNum = randi_range(0,(q_buttons.size() - 1))
		var chosenButton = q_buttons[randomNum]
		OptionsContainer.add_child(chosenButton)
		q_buttons.remove_at(randomNum)
	
func personality_tally():
	var tally = [amb_num, comp_num, cour_num]
	var highest = tally.max()
	var max_index = tally.find(highest)
	
	if max_index == 0:
		last_soul = "Ambitious"
	elif max_index == 1:
		last_soul = "Compassionate"
	elif max_index == 2:
		last_soul = "Courage"
		
	print(last_soul)
		
	await get_tree().create_timer(1.5).timeout
	
	Terminus.visible = true
	DialogueManager.show_dialogue_balloon(resource, "test_done")
	
	await DialogueManager.dialogue_ended
	
	create_tween().tween_property(Music.PersonalityTest, "volume_db", -90.0, 3)
	SceneLoader.load_scene("uid://c6yf5n1fbfsm8", 1)

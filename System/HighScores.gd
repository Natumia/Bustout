extends Node

var configSave = "user://Bustout.dat"

var scores = [10000, 25000, 50000, 75000, 100000]

func save_scores(inputScore):
	scores.sort()
	
	if inputScore > scores[0]:
		scores.pop_front()
		scores.append(inputScore)
		
		scores.sort()
	
	var file = File.new()
	file.open(configSave, File.WRITE)
	file.store_var(scores)
	file.close()

func load_scores():
	var file = File.new()
	if file.file_exists(configSave):
		file.open(configSave, File.READ)
		scores = file.get_var()
		file.close()
		return true
	else:
		return false

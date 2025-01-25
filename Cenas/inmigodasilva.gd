extends CharacterBody2D

var life = 100.0

func _ready():
	life = 100.0
	

func decrease_life(amount):
	if (amount>0):
		life-=amount;
	if (life <0):
		life = 0;
	
func increase_life(amount):
	if (amount>0 || life<100):
		life+=amount;
	if (life>100):
		life=100

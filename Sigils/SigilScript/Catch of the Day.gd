extends SigilEffect

# This is called whenever something happens that might trigger a sigil, with 'event' representing what happened
func handle_event(event: String, params: Array):
	# attached_card_summoned represents the card bearing the sigil being summoned
	if event == "card_perished" and params[0] == card and isFriendly:
		var fish : Array = ["Bad","More","Good"]
		randomize()
		fish.shuffle()
		print(fish)
		match fish:
			["Bad",_,_]: fightManager.draw_card(CardInfo.from_name("Bad Fish"))
			["More",_,_]: fightManager.draw_card(CardInfo.from_name("More Fish"))
			_: fightManager.draw_card(CardInfo.from_name("Good Fish"))

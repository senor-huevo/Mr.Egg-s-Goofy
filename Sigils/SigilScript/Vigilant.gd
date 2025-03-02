extends SigilEffect

# This is called whenever something happens that might trigger a sigil, with 'event' representing what happened
func handle_event(event: String, params: Array):

	# Was card summoned / moved to the space opposing this one?
	
	# On the board
	if not card.in_hand:
		if event in ["card_summoned", "card_moved"]:
			# Fuck necromancer. All my homies hate necromancer
			if params[0].get_node("AnimationPlayer").current_animation == "DoublePerish":
				return
			
			# Cannot see if dead or double dead
			if card.get_node("AnimationPlayer").current_animation != "Perish" \
			and card.get_node("AnimationPlayer").current_animation != "DoublePerish":
				
				# If I'm moving, hit 'em where it hurts
				if params[0] == card and event == "card_moved":
					hit_and_run(params)
				else:
					normal_behaviour(params)

func normal_behaviour(params: Array):
			
	# Target card must be in opposing spaces
	if params[0].get_parent().get_parent() == card.get_parent().get_parent():
		return
	
	# Target card must be in same slot
	if params[0].slot_idx() != card.slot_idx():
		return
	
	if isFriendly:
		
		print("Vigilant triggered!")
		
		var old_data = card.card_data.duplicate()
		old_data.sigils = old_data.sigils.duplicate()
		
		old_data.sigils.erase("Vigilant")

		# wait a bit so both client catch up to eachother
		yield(fightManager.get_tree().create_timer(0.05), "timeout")

		# Draw the modified card copy
		fightManager.draw_card(old_data)
				
func hit_and_run(_params: Array):
	var opposing_card = \
		slotManager.get_enemy_card(card.slot_idx()) if isFriendly \
		else slotManager.get_friendly_card(card.slot_idx())
	
	if opposing_card:
		if isFriendly:
		
			print("Vigilant triggered!")
		
			var old_data = card.card_data.duplicate()
			old_data.sigils = old_data.sigils.duplicate()

			old_data.sigils.erase("Vigilant")

			# Draw the modified card copy
			fightManager.draw_card(old_data)

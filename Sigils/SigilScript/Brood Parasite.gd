extends SigilEffect

# This is called whenever something happens that might trigger a sigil, with 'event' representing what happened
func handle_event(event: String, params: Array):

	# attached_card_summoned represents the card bearing the sigil being summoned
	if event == "card_summoned" and params[0] == card:
		var slot_idx = card.slot_idx() 
		if slotManager.is_slot_empty(slotManager.enemySlots[slot_idx]) and isFriendly:
					slotManager.summon_card(CardInfo.from_name("Broken Egg"), slot_idx, false)
					print("Summoning Egg into enemy slot ", slot_idx)
		else:			
					if slotManager.is_slot_empty(slotManager.playerSlots[slot_idx]):
						slotManager.summon_card(CardInfo.from_name("Broken Egg"), slot_idx, true)
					print("Summoning Egg into friendly slot ", slot_idx)

extends SigilEffect

# This is called whenever something happens that might trigger a sigil, with 'event' representing what happened
func handle_event(event: String, params: Array):

	# attached_card_summoned represents the card bearing the sigil being summoned
	if event == "card_perished" and params[0] == card:
		
		print("Shallow Graves triggered!")
		
		var cardSlots = slotManager.playerSlots if isFriendly else slotManager.enemySlots
		var slot = card.slot_idx()
		
		if slot > 0 and slotManager.is_slot_empty(cardSlots[slot - 1]):
			slotManager.summon_card(CardInfo.from_name("Coffin"), slot - 1, isFriendly)

		if slot < 3 and slotManager.is_slot_empty(cardSlots[slot + 1]):
			slotManager.summon_card(CardInfo.from_name("Coffin"), slot + 1, isFriendly)

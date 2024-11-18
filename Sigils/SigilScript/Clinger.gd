extends SigilEffect

# This is called whenever something happens that might trigger a sigil, with 'event' representing what happened
func handle_event(event: String, params: Array):

	if event == "card_summoned" and not card.in_hand and (params[0].get_parent().get_parent().name == "PlayerSlots") == isFriendly:
		if params[0] != card:
			for movSigil in ["Clinger"]:
				var slot_idx = params[0].slot_idx()
				var offset = 0
				var cardSlots = slotManager.playerSlots if isFriendly else slotManager.enemySlots
				var curslot = card.slot_idx()
				var sprintSigil = card.get_node("CardBody/Sigils/Row1").get_child(card.card_data["sigils"].find(movSigil))
				
				# if the left is empty
				if curslot < slot_idx:
					sprintSigil.flip_h = false
					if slot_idx <= 3 and slot_idx > 1 and slotManager.is_slot_empty(cardSlots[slot_idx - 1]):
						offset = -1
					elif slot_idx <= 3 and slot_idx > 1 and slotManager.is_slot_empty(cardSlots[slot_idx - 2]) and (slot_idx - 1) != curslot:
						offset = -2
				if curslot > slot_idx:
					sprintSigil.flip_h = true
					 # if the right is empty
					if slot_idx < 2 and slot_idx >= 0 and slotManager.is_slot_empty(cardSlots[slot_idx + 1]):
						offset = 1
					elif slot_idx < 2 and slot_idx >= 0 and slotManager.is_slot_empty(cardSlots[slot_idx + 2]) and (slot_idx + 1) != curslot:
						offset = 2
				if offset != 0:
					card.move_to_parent(cardSlots[slot_idx + offset])

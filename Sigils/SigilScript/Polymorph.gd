extends SigilEffect

# This is called whenever something happens that might trigger a sigil, with 'event' representing what happened
func handle_event(event: String, params: Array):

	# attached_card_summoned represents the card bearing the sigil being summoned
	if event == "card_summoned" and params[0] == card:
		
		var opposing_card = \
		slotManager.get_enemy_card(card.slot_idx()) if isFriendly \
		else slotManager.get_friendly_card(card.slot_idx())
		
		opposing_card.from_data(CardInfo.from_name("Sock Sorcerer"))
		
		var cardAnim = opposing_card.get_node("AnimationPlayer")
		
		if opposing_card.get_node("CardBody/DiveOlay").visible:
			cardAnim.play("UnDive")
			

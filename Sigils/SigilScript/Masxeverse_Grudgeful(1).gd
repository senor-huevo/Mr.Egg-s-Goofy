extends SigilEffect

func handle_event(event: String, params: Array):
    if event == "card_perished" and params[0] == card:
        if isFriendly:
               fightManager.inflict_damage(-1)
        else:
               fightManager.inflict_damage(1)
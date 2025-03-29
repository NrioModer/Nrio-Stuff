SMODS.BlindEdition {
    key = 'prismatic',
    blind_shader = 'ns_prismatic',
    weight = 0,
    dollars_mod = -1,
    loc_txt = {
        name = "Prismatic",
        text = {
		"-#1# Hand Size, Discard",
		"and Hand. Create a",
                "Spectral card"
	}
    },
    loc_vars = function(self, blind_on_deck)
        return {1}
    end,
    collection_loc_vars = function(self, blind_on_deck)
        return {1}
    end,
    set_blind = function(self, blind_on_deck)
	ease_discard(-1)
	if G.GAME.current_round.hands_left > 1 then
            ease_hands_played(-1)
        end
	G.hand:change_size(-1)
    end,
    defeat = function(self, blind_on_deck)
	G.hand:change_size(1)
	if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        G.E_MANAGER:add_event(Event({
                            func = function() 
                                local card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'car')
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                G.GAME.consumeable_buffer = 0
                                return true
                            end}))   
                        return true
                    end)}))
        end
    end,
    in_pool = function(self, blind_type)
        boss_blind = G.GAME.round_resets.blind_choices.Boss 
        if (boss_blind == "bl_needle") or (boss_blind == "bl_cruel_sword") or (boss_blind == "bl_jen_one") then
            return false
        end
        if (boss_blind == "bl_cry_obsidian_orb") then
            for i, j in pairs(G.GAME.defeated_blinds) do
                if (i == "bl_needle") or (i == "bl_cruel_sword") or (i == "bl_jen_one") then
                    return false
                end
            end
        end
        return true
    end
}
SMODS.BlindEdition {
    key = 'divinatory',
    blind_shader = 'ns_divinatory',
    weight = 0.35,
    dollars_mod = 0,
    loc_txt = {
        name = "Divinatory",
        text = {
		"X#1# Discard",
                "Create a Tarot card"
	}
    },
    loc_vars = function(self, blind_on_deck)
        return {0.5}
    end,
    collection_loc_vars = function(self, blind_on_deck)
        return {0.5}
    end,
    set_blind = function(self, blind_on_deck)
	self.ability = 0
	self.ability = math.floor(G.GAME.current_round.discards_left * 0.5)
        ease_discard(-1*self.ability)
    end,
    defeat = function(self, blind_on_deck)
        ease_discard(self.ability)
	if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        G.E_MANAGER:add_event(Event({
                            func = function() 
                                local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'car')
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                G.GAME.consumeable_buffer = 0
                                return true
                            end}))   
                        return true
                    end)}))
        end
    end
}
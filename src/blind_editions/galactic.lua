SMODS.BlindEdition {
    key = 'galactic',
    blind_shader = 'ns_galactic',
    weight = 0.25,
    dollars_mod = 4,
    loc_txt = {
        name = "Galactic",
        text = {
		"Temporary decrease",
                "level of every poker",
                "hand by {C:attention}1{} level"
	}
    },
    loc_vars = function(self, blind_on_deck)
        return {1}
    end,
    collection_loc_vars = function(self, blind_on_deck)
        return {1}
    end,
    set_blind = function(self, blind_on_deck)
        for k, v in pairs(G.GAME.hands) do
            level_up_hand(self, k, true, -1)
        end
    end,
    defeat = function(self, blind_on_deck)
        for k, v in pairs(G.GAME.hands) do
            level_up_hand(self, k, true)
        end
    end
}
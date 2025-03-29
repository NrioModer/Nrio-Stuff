SMODS.BlindEdition {
    key = 'positive',
    blind_shader = 'ns_positive',
    weight = 0.45,
    loc_txt = {
        name = "Positive",
        text = {
            "X#1# Blind Size",
            "-#2# Dollars Reward"
        }
    },
    blind_size_mult = 0.75,
    dollars_mod = -2,
    loc_vars = function(self, blind_on_deck)
        return {0.75, 2}
    end,
    collection_loc_vars = function(self, blind_on_deck)
        return {0.75, 2}
    end,
    defeat = function(self, blind_on_deck)
	G.P_BLIND_EDITIONS.ble_ns_prismatic.weight = G.P_BLIND_EDITIONS.ble_ns_prismatic.weight + 0.1
    end
}
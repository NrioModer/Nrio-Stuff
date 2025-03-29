local cs = {
    name = "Turquoise Sleeve",
    atlas = 1,
    loc_vars = function(self)
        local key, vars
        if self.get_current_deck_key() == "b_ns_turquoise" then
            key = self.key .. "_alt"
            self.config = {}
            vars = {}
        else
            key = self.key
            self.config = { discards = -2, hands = 2 }
            vars = { self.config.hands, self.config.discards }
        end
        return { key = key, vars = vars }
    end,
}


function cs:apply()
	G.GAME.starting_params.ns_turquoise_sleeve = true
	if self.get_current_deck_key() ~= "b_ns_turquoise" then
		G.GAME.starting_params.hands = G.GAME.starting_params.hands + self.config.hands
		G.GAME.starting_params.discards = G.GAME.starting_params.discards + self.config.discards
	end
end

return cs

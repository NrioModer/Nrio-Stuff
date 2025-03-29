local cs = {
    name = "Abstract Sleeve",
    atlas = 3,
    loc_vars = function(self)
        local key, vars
        if self.get_current_deck_key() == "b_ns_abstract" then
            key = self.key .. "_alt"
            self.config = {}
            vars = {}
        else
            key = self.key
            config = {hand_size = 1}
            vars = { config.hand_size }
        end
        return { key = key, vars = vars }
    end,
}


function cs:apply()
	G.GAME.starting_params.ns_abstract_sleeve = true
	if self.get_current_deck_key() ~= "b_ns_abstract" then
        	G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + self.config.hand_size
    	end
end

return cs

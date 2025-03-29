local cs = {
    name = "Concert Sleeve",
    atlas = 2,
    loc_vars = function(self)
        local key, vars
        if self.get_current_deck_key() == "b_ns_concert" then
            key = self.key .. "_alt"
            self.config = {}
            vars = {}
        else
            key = self.key
            config = {multiedition = 1.5, money_max = 50}
            vars = { config.multiedition, config.money_max }
        end
        return { key = key, vars = vars }
    end,
}


function cs:apply()
	G.GAME.starting_params.ns_concert_sleeve = true
end

return cs

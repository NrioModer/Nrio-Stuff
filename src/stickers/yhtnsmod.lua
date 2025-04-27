local all_sets = {}
for i,k in pairs(G.P_CENTER_POOLS) do
    all_sets[i] = true
end

local st = {
    key = 'yhtnsmod',
    loc_txt = {
        name="You have the nrio stuff mod",
        label='You have the nrio stuff mod',
                text = {
        		"suggest what to write"
        	},
            },
    badge_colour = HEX '91cf60',
    hide_badge = false,
    default_compat = true,
    needs_enable_flag = false,
    sets = all_sets,
    rate = 0,
    atlas = 1,
    calculate = function(self, card, context)
    end,
    apply = function(self, card, val)
        card.ability[self.key] = val
    end,
}

function Card:set_yhtnsmod(yhtnsmod)
    SMODS.Stickers['ns_yhtnsmod']:apply(self, yhtnsmod)
end

return st
function aprilbalalalaalalalalalaalalalalalallalal()
	local apriltaro = {}
	for k, v in pairs(G.P_CENTER_POOLS.Tarot) do
    		if v.key ~= "c_fool" then
        		table.insert(apriltaro, {id = v.key})
    		end
	end
	return apriltaro
end

SMODS.Challenge {
    key = "april_fool",
    loc_txt = {
        name = "April fool",
    },
    rules = {
    },
    restrictions = {
    	banned_cards = aprilbalalalaalalalalalaalalalalalallalal(),
    },
}
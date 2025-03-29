SMODS.Sound{
	key = "positivesound",
	path = "positive.ogg"
}
SMODS.Shader{
	key = "positive",
	path = "positive.fs",
}
SMODS.Edition{
	key = "positive",
	shader = "positive",
	loc_txt = {
        	name="Positive",
        	label='Positive',
                	text = {
        			"{C:inactive}Does nothing!?!"
        		},
        },
	unlocked = true,
    	discovered = true,
	in_shop = true,
	weight = 30,
	extra_cost = -2,
	sound = { sound = "ns_positivesound", per = 1.2, vol = 0.9 },
	config = {},
	calculate = function(self, card, context)
		if context.pre_joker or (context.main_scoring and context.cardarea == G.play and not context.repetition) then
			G.P_CENTERS.e_ns_prismatic.in_shop = true
		end
	end
}
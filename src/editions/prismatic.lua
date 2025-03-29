SMODS.Sound{
	key = "prismaticsound",
	path = "prismatic.ogg"
}
SMODS.Shader{
	key = "prismatic",
	path = "prismatic.fs",
}
SMODS.Edition{
	key = "prismatic",
	shader = "prismatic",
	loc_txt = {
        	name="Prismatic",
        	label='Prismatic',
                	text = {
        			"Create a {C:spectral}Spectral{} card",
				"and spend {C:money}$#1#{}",
				"{C:inactive}(Must have room)"
        		},
        },
	unlocked = true,
    	discovered = true,
	in_shop = false,
	weight = 6,
	extra_cost = 6,
	sound = { sound = "ns_prismaticsound", per = 1.2, vol = 0.9 },
	config = { cost = 6 },
	loc_vars = function(self, info_queue, card, area)
		return {
			vars = {
				card.edition.cost
			},
		}
	end,
	calculate = function(self, card, context)
	   if context.main_scoring and context.cardarea == G.play and not context.repetition and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
		card.ability.spec_create = card.ability.spec_create or 0
            	card.ability.spec_create = card.ability.spec_create + 0.5
		if card.ability.spec_create >= 1 then
			local spend_money = card.edition.cost
			play_sound('tarot1')
			card.ability.spec_create = 0
                	G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                	local card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'car')
                	card:add_to_deck()
                	G.consumeables:emplace(card)
                	G.GAME.consumeable_buffer = 0
			return {
                        	dollars = -1*spend_money
                	}
		end
            end
	    if context.pre_joker and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
		play_sound('tarot1')
		local spend_money = card.edition.cost
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                local card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'car')
                card:add_to_deck()
                G.consumeables:emplace(card)
                G.GAME.consumeable_buffer = 0
		return {
                        dollars = -1*spend_money
                }
            end
	end
}
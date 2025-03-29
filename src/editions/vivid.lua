SMODS.Sound{
	key = "divinatorysound",
	path = "divinatory.ogg"
}
SMODS.Shader{
	key = "vivid",
	path = "vivid.fs",
}
SMODS.Edition{
	key = "vivid",
	shader = "vivid",
	loc_txt = {
        	name="Vivid",
        	label='Vivid',
                	text = {
        			"{C:mult}X#1#{} Mult",
				"Create a {C:colourcard}Colour{} card",
          			"{C:inactive}(Must have room)"
        		},
        },
	unlocked = true,
    	discovered = true,
	in_shop = true,
	weight = 14,
	extra_cost = 4,
	sound = { sound = "ns_divinatorysound", per = 1.2, vol = 1.5 },
	config = { lose_xmult = 2/3},
	loc_vars = function(self, info_queue, card, area)
		return {
			vars = {
				card.edition.lose_xmult
			},
		}
	end,
	calculate = function(self, card, context)
	   if context.main_scoring and context.cardarea == G.play and not context.repetition and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
		card.ability.col_create = card.ability.col_create or 0
            	card.ability.col_create = card.ability.col_create + 0.5
		if card.ability.col_create >= 1 then
			local lxmult = card.edition.lose_xmult
			play_sound('tarot1')
			card.ability.col_create = 0
                	G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                	local card = create_card('Colour',G.consumeables, nil, nil, nil, nil, nil, 'car')
                	card:add_to_deck()
                	G.consumeables:emplace(card)
                	G.GAME.consumeable_buffer = 0
			return {
                		message = localize('k_plus_colour'),
				x_mult_mod = lxmult,
				colour = G.C.PURPLE
            		}
		end
            end
	    if context.pre_joker and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
		local lxmult = card.edition.lose_xmult
		play_sound('tarot1')
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                local card = create_card('Colour',G.consumeables, nil, nil, nil, nil, nil, 'car')
                card:add_to_deck()
                G.consumeables:emplace(card)
                G.GAME.consumeable_buffer = 0
		return {
                	message = localize('k_plus_colour'),
			x_mult_mod = lxmult,
			colour = G.C.PURPLE
            	}
            end
	end
}
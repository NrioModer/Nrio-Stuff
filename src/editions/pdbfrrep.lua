SMODS.Sound{
	key = "divinatorysound",
	path = "divinatory.ogg"
}
SMODS.Shader{
	key = "pdbfrrep",
	path = "pdbfrrep.fs",
}
SMODS.Edition{
	key = "pdbfrrep",
	shader = "pdbfrrep",
	loc_txt = {
        	name="Pi Divided By Four Radians Revolved Esoteric Portents",
        	label='Pi Divided By Four Radians Revolved Esoteric Portents',
                	text = {
				"If the current current is between 30 and 60 percent",
				"of the blind, create a {C:rotarot}45 Degree Rotated Tarot{} card",
                    		"{C:inactive}(Must have room)"
        		},
        },
	unlocked = true,
    	discovered = true,
	in_shop = true,
	weight = 3.14*4,
	extra_cost = 3,
	sound = { sound = "ns_divinatorysound", per = 1.2, vol = 1.5 },
	config = {},
	calculate = function(self, card, context)
	   if context.main_scoring and context.cardarea == G.play and not context.repetition and hand_chips * mult > G.GAME.blind.chips * 0.3 and hand_chips * mult < G.GAME.blind.chips * 0.6 and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
		card.ability.rotarot_create = card.ability.rotarot_create or 0
            	card.ability.rotarot_create = card.ability.rotarot_create + 0.5
		if card.ability.rotarot_create >= 1 then
			play_sound('tarot1')
			card.ability.rotarot_create = 0
                	G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                	local card = create_card('Rotarot',G.consumeables, nil, nil, nil, nil, nil, 'car')
                	card:add_to_deck()
                	G.consumeables:emplace(card)
                	G.GAME.consumeable_buffer = 0
			return {
                		message = localize('k_rotarot'),
				colour = G.C.PURPLE
            		}
		end
            end
	    if context.pre_joker and hand_chips * mult > G.GAME.blind.chips * 0.3 and hand_chips * mult < G.GAME.blind.chips * 0.6 and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
		play_sound('tarot1')
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                local card = create_card('Rotarot',G.consumeables, nil, nil, nil, nil, nil, 'car')
                card:add_to_deck()
                G.consumeables:emplace(card)
                G.GAME.consumeable_buffer = 0
		return {
                	message = localize('k_rotarot'),
			colour = G.C.PURPLE
            	}
            end
	end
}
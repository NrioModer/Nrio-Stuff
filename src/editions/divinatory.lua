SMODS.Sound{
	key = "divinatorysound",
	path = "divinatory.ogg"
}
SMODS.Shader{
	key = "divinatory",
	path = "divinatory.fs",
}
SMODS.Edition{
	key = "divinatory",
	shader = "divinatory",
	loc_txt = {
        	name="Divinatory",
        	label='Divinatory',
                	text = {
        			"If the current score is greater",
				"than the blind, create a {C:tarot}Tarot{} card",
                    		"{C:inactive}(Must have room)",
        		},
        },
	unlocked = true,
    	discovered = true,
	in_shop = true,
	weight = 16,
	extra_cost = 4,
	sound = { sound = "ns_divinatorysound", per = 1.2, vol = 1.5 },
	config = {},
	calculate = function(self, card, context)
	   if context.main_scoring and context.cardarea == G.play and not context.repetition and hand_chips * mult > G.GAME.blind.chips and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
		card.ability.taro_create = card.ability.taro_create or 0
            	card.ability.taro_create = card.ability.taro_create + 0.5
		if card.ability.taro_create >= 1 then
			play_sound('tarot1')
			card.ability.taro_create = 0
                	G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                	local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'car')
                	card:add_to_deck()
                	G.consumeables:emplace(card)
                	G.GAME.consumeable_buffer = 0
			return {
                		message = localize('k_plus_tarot'),
				colour = G.C.PURPLE
            		}
		end
            end
	    if context.pre_joker and hand_chips * mult > G.GAME.blind.chips and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
		play_sound('tarot1')
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'car')
                card:add_to_deck()
                G.consumeables:emplace(card)
                G.GAME.consumeable_buffer = 0
		return {
                	message = localize('k_plus_tarot'),
			colour = G.C.PURPLE
            	}
            end
	end
}
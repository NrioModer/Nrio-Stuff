local d = {
  loc_txt = {
    name = "Turquoise Deck",
    text = {
      "{C:attention}+#1#{} hands, {C:red}#2#{} discards",
      "You {C:attention}can convert{}",
      "hands to discard",

    },
  },
  config = {discards = -2, hands = 2, ns_turquoise = true },
  atlas = 1,
}

function d:loc_vars()
  return { vars = { d.config.hands, d.config.discards} }
end

function d:apply()
	G.GAME.starting_params.ns_turquoise = true
end

local create_UIBox_buttons_safe=create_UIBox_buttons
	function create_UIBox_buttons()
	local ret=create_UIBox_buttons_safe()
	local text_scale=0.225
        local button_height=1.3
        if G.GAME.starting_params.ns_turquoise or G.GAME.starting_params.ns_turquoise_sleeve then
            local convert_hand = {n=G.UIT.C, config={id = 'convert_hand', align = "tm", minw = 1.25, padding = 0.3, r = 0.1, hover = true, colour = G.C.BLUE, button = "this is another useless parameter", one_press = false, shadow = true, func = 'can_convert_hands'}, nodes={
      		{n=G.UIT.R, config={align = "bcm", padding = 0}, nodes={
        		{n=G.UIT.T, config={text = localize('ns_b_convert_hand'), scale = text_scale, colour = G.C.UI.TEXT_LIGHT, focus_args = {button = 'x', orientation = 'bm'}, func = 'set_button_pip'}}
      		}},
    	    }}
	    if G.SETTINGS.play_button_pos == 1 then
            	table.insert(ret.nodes,4,convert_hand)
	    else
		table.insert(ret.nodes,2,convert_hand)
	    end
        end
	if G.GAME.starting_params.ns_turquoise and G.GAME.starting_params.ns_turquoise_sleeve then
    	    local convert_discard = {n=G.UIT.C, config={id = 'convert_discard', align = "tm", minw = 1.25, padding = 0.3, r = 0.1, hover = true, colour = G.C.RED, button = "this is another useless parameter", one_press = false, shadow = true, func = 'can_convert_discards'}, nodes={
      		{n=G.UIT.R, config={align = "bcm", padding = 0}, nodes={
        		{n=G.UIT.T, config={text = localize('ns_b_convert_discard'), scale = text_scale, colour = G.C.UI.TEXT_LIGHT, focus_args = {button = 'x', orientation = 'bm'}, func = 'set_button_pip'}}
      		}},
    	    }}
            if G.SETTINGS.play_button_pos == 1 then
            	table.insert(ret.nodes,2,convert_discard)
	    else
		table.insert(ret.nodes,5,convert_discard)
	    end
        end
	return ret
end

G.FUNCS.can_convert_hands=function(e)
    if G.GAME.current_round.hands_left <= 1 or #G.hand.highlighted <= 0 then 
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        e.config.colour = G.C.BLUE
        e.config.button = 'converting_hand_to_discard'
    end
end

G.FUNCS.converting_hand_to_discard=function(e)
        ease_hands_played(-1)
	ease_discard(1)
end

G.FUNCS.can_convert_discards=function(e)
    if G.GAME.current_round.discards_left <= 0 or #G.hand.highlighted <= 0 then 
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
        e.config.colour = G.C.RED
        e.config.button = 'converting_discard_to_hand'
    end
end

G.FUNCS.converting_discard_to_hand=function(e)
        ease_hands_played(1)
	ease_discard(-1)
end

return d

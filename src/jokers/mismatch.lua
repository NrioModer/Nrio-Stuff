local j = {
  loc_txt = {
    name = "The Mismatch",                                   
        text = {
            "{X:mult,C:white} X#1# {} Mult",
	    "Every poker hand",
	    "contains a {C:attention}Flush{}"                    
        },
  },
  config = {extra = {x_mult = 1/2}},
  rarity = 2,
  cost = 7,
  atlas = 65,
  blueprint_compat = false,
}

function j:loc_vars(_, card)
	return { vars = { card.ability.extra.x_mult} }
end


function j:calculate(card, context)
	if context.joker_main then
	    return {
        	message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
        	Xmult_mod = card.ability.extra.x_mult,
      	    }  
        end
end

local get_flush_ns = get_flush
function get_flush(hand)
	 local a = get_flush_ns(hand)
	 if next(find_joker("j_ns_mismatch")) and #a == 0 then
		if #get_straight(hand) ~= 0 then
			a = get_straight(hand)
		elseif #get_X_same(3,hand) ~= 0 then
			a = get_X_same(3,hand)
		elseif #get_X_same(2,hand) ~= 0 then
			a = get_X_same(2,hand)
		else
			a = get_highest(hand)
		end
	 end
	 return a
end

if JokerDisplay then
    JokerDisplay.Definitions["j_ns_mismatch"] = {
    	text = {
            {
                border_nodes = {
                    { text = "X" },
                    { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }
                }
            }
        },
	calc_function = function(card)
		card.joker_display_values.x_mult = card.ability.extra.x_mult
        end
    }
end
	
return j

local j = {
  loc_txt = {
    name = "The Lone",                                   
        text = {
            "{X:mult,C:white} X#1# {} Mult",
	    "Every {C:attention}matching rank{} in a poker",
	    "hand {C:attention}upgrades{} to the next tier"                    
        },
  },
  config = {extra = {x_mult = 0.4}},
  rarity = 2,
  cost = 7,
  atlas = 67,
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

local get_X_same_test = get_X_same
function get_X_same(num, hand, or_more)
	a = get_X_same_test(num, hand, or_more)
	if next(find_joker("j_ns_lone")) and #a == 0 and num ~= 2 then
		a = get_X_same_test(num-1, hand, or_more)
	end
	return a
end

if JokerDisplay then
    JokerDisplay.Definitions["j_ns_lone"] = {
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

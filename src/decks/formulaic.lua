local d = {
  loc_txt = {
    name = "Formulaic Deck", --good deck#$^###^%#$%
    text = {
      "After hand, {C:attention}Chips{} becomes",
      "{C:blue}Chips{}*{C:red}Mult{}/({C:blue}Chips{}+{C:red}Mult{})",
      "and {C:attention}Mult{} becomes 100",

    },
  },
  config = {},
  atlas = 4,
}

function d:loc_vars()
  return { vars = {} }
end

function d:apply()
	G.GAME.starting_params.ns_formulaic = true
end

local get_blind_amount_ref = get_blind_amount
function get_blind_amount(ante)
    local amount = get_blind_amount_ref(ante)
    if G.GAME.starting_params.ns_formulaic or G.GAME.starting_params.ns_formulaic_sleeve then
    	amount = amount * (math.max(ante, 1)^-0.912) * 2
	local num = 10^math.floor(math.log10(amount))/10
	amount = math.floor(amount / num) * num / 2
    end
    return amount
end

return d

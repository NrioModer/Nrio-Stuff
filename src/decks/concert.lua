local d = {
  loc_txt = {
    name = "Concert Deck",
    text = {
      "{C:attention}X#1#{} to all {C:dark_edition}Edition",
      "Money cannot exceed {C:money}$#2#",

    },
  },
  config = {multiedition = 1.5, money_max = 50},
  atlas = 2,
}

function d:loc_vars()
  return { vars = { d.config.multiedition, d.config.money_max} }
end

function d:apply()
	G.GAME.starting_params.ns_concert = true
end


return d

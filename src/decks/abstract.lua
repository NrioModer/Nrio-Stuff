local d = {
  loc_txt = {
    name = "Abstract Deck",
    text = {
    	"{C:attention}+#1#{} hand size",
	"At end of the round, {C:attention}change{}",
	"suit and rank of cards in hand"

    },
  },
  config = {hand_size = 1},
  atlas = 3,
}

function d:loc_vars()
  return { vars = { d.config.hand_size} }
end

function d:apply()
	G.GAME.starting_params.ns_abstract = true
end

return d

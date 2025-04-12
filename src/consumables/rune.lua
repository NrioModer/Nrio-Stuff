local c = {
  primary_colour = HEX("b38cc2"),
  secondary_colour = HEX("c5acce"),
  loc_txt = {
    name = "Rune",
    collection = "Rune Cards",
    undiscovered = {
      name = "Not Dicovered",
      text = {
        "Purchase or use",
        "this card in an",
        "unseeded run to",
        "learn what it does",
      },
    },
  },
  shop_rate = 2.0,
  default = "c_bplus_rune_blank",
  atlas = "consumables/runes.png",
  collection_rows = { 4, 4 },
  cards = {
    "jera",
    "perthro",
    "ansuz",
    "dagaz",
    "hagalaz",
    "berkano",
    "ehwaz",
    "algiz"
  },
}

return c

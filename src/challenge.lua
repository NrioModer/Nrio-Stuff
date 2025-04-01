return function(challenge_dir, challenges)
  for k, c in pairs(challenges) do
    if type(c) == "string" then
      if type(k) == "number" then
        k = c
      end
      c = NrioStuff.load(challenge_dir .. "/" .. c) or e
    end
  end
end

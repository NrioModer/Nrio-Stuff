return function(edition_dir, editions)
  for k, e in pairs(editions) do
    if type(e) == "string" then
      if type(k) == "number" then
        k = e
      end
      e = NrioStuff.load(edition_dir .. "/" .. e) or e
    end
  end
end

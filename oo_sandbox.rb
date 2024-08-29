def value(rank)
  case rank
  when (2..10) then rank.to_i
  when 'Ace' then 11
  else 10
  end
end

p value(3)

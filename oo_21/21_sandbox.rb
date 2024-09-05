UPPERCASE = ('A'..'Z').to_a
LOWERCASE = ('a'..'z').to_a

def letter_changes(string)
  string.chars.map do |char|
    (UPPERCASE + LOWERCASE).include?(char) ? shift(char) : char
  end.join
end

def shift(char)
  if UPPERCASE.include?(char)
    UPPERCASE[shift_index(UPPERCASE.index(char))]
  elsif LOWERCASE.include?(char)
    LOWERCASE[shift_index(LOWERCASE.index(char))]
  end
end

def shift_index(index)
  (index + 26 + 3) % 26
end

shifted = (0..25).map { |index| (index + 26 + 3) % 26 }
letter_index = UPPERCASE.index('A')
shifted_index = shifted[letter_index]

p UPPERCASE[shifted_index]
###

###
# UPPERCASE = ('A'..'Z').to_a + ('A'..'C').to_a
# LOWERCASE = ('a'..'z').to_a + ('a'..'c').to_a

# def letter_changes(string)
#   string.chars.map do |char|
#     (UPPERCASE + LOWERCASE).include?(char) ? shift(char) : char
#   end.join
# end

# def shift(char)
#   if UPPERCASE.include?(char)
#     index = UPPERCASE.index(char)
#     UPPERCASE[index + 3]
#   else
#     index = LOWERCASE.index(char)
#     LOWERCASE[index + 3]
#   end
# end
###
#
p letter_changes('abc') == 'def'
p letter_changes('WxY') == 'ZaB'
p letter_changes('364.39') == '364.39'
p letter_changes("JaneDoe37@gmail.com") == 'MdqhGrh37@jpdlo.frp'

# FizzBuzzの課題

number = 1
fizz = 3
buzz = 5
while number <= 20                                   # 1~20までをループ
  if (number % fizz).zero? && (number % buzz).zero?  # 3と5の倍数
    puts 'FizzBuzz'
  elsif (number % fizz).zero?                        # 3の倍数
    puts 'Fizz'
  elsif (number % buzz).zero?                        # 5の倍数
    puts 'Buzz'
  else
    puts number
  end
  number += 1
end

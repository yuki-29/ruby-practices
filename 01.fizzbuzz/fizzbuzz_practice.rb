number = 1 
FIZZ = 3
BUZZ = 5

while number <= 20                                   
  if (number % FIZZ).zero? && (number % BUZZ).zero?  
    puts  'FizzBuzz'
  elsif (number % FIZZ).zero?                        
    puts  'Fizz'
  elsif (number % BUZZ).zero?                        
    puts 'Buzz'
  else
    puts number
  end
  number += 1
end

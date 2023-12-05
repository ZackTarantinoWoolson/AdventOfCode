Dir.chdir(File.dirname(__FILE__))
input=File.open("puzzleInput.txt").readlines.map(&:chomp)
# input=File.open("teststrings.txt").readlines.map(&:chomp)


def get_winning_numbers(line)
    line.split(" | ")[0].split(":")[1].split(" ")
end

def get_play_numbers(line)
    line.split(" | ")[1].split(" ")
end




total_points=0

input.each do |line|
    wins=0
    game_array=Array.new
    game_id= line.split(": ")[0].split(" ")[1]
    
    winning_numbers= get_winning_numbers(line)

    get_play_numbers(line).each do |num|
        if winning_numbers.include?(num)
            wins+=1
        end
    end

    total_points+=calculate_points(wins)
end

p "Part 1: #{total_points}"
# p "Part 2: #{product}"
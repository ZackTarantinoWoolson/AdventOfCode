Dir.chdir(File.dirname(__FILE__))
input=File.open("puzzleInput.txt").readlines.map(&:chomp)
# input=File.open("teststrings.txt").readlines.map(&:chomp)


def get_winning_numbers(line)
    line.split(" | ")[0].split(":")[1].split(" ")
end

def get_play_numbers(line)
    line.split(" | ")[1].split(" ")
end

def calculate_points(wins)
    points=0
    if wins>1
        points+=1
        (1..wins-1).each do |x|
            points=points*2
        end
    elsif wins==1
        points+=1
    end
    points
end

### Part 1: 
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

input.each do |line|
    wins=0
    game_array=Array.new
    game_id= line.split(": ")[0].split(" ")[1]

    winning_numbers= get_winning_numbers(line)

    get_play_numbers(line).each do |num|
        if winning_numbers.include?(num)
            #card instances
        end
    end
end


# p "Part 2: #{product}"
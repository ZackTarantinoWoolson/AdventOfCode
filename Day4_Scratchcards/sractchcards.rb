Dir.chdir(File.dirname(__FILE__))
# $input=File.open("puzzle$input.txt").readlines.map(&:chomp)
$input=File.open("teststrings.txt").readlines.map(&:chomp)


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

def calculate_card_instances(wins,ind)
    new_cards=Array.new
    # p "number of wins: #{wins} for card #{ind}"
    (1..wins).each do |x|
        new_cards<<ind+x
    end

    new_cards
end

def preset_game_ids
    hs=Hash.new
    $input.each do |line|
        game_id= line.split(": ")[0].split(" ")[1]
        hs[game_id.to_i]=1
    end
    hs
end

### Part 1: 
total_points=0

$input.each do |line|
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

### Part 2:

total_instances=preset_game_ids
$input.each_with_index do |line,ind|
    
    
    game_array=Array.new
    game_id= line.split(": ")[0].split(" ")[1]

    # p total_instances[game_id.to_i]

    (1..total_instances[game_id.to_i]).each do |x|
        wins=0

        # total_instances[game_id.to_i]=1
        # p total_instances

        winning_numbers= get_winning_numbers(line)

        get_play_numbers(line).each do |num|
            if winning_numbers.include?(num)
                wins+=1
            end
        end

        calculate_card_instances(wins,ind+1).each do |game|
            # p "game: #{game}"
            total_instances[game]+=1 unless game>total_instances.keys.last
        end
    end
end

total_instances.each {|x| total+=x}


# p "Part 2: #{product}"
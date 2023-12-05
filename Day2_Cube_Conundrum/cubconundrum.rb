Dir.chdir(File.dirname(__FILE__))
# input=File.open("puzzleInput.txt").readlines.map(&:chomp)
input=File.open("teststrings.txt").readlines.map(&:chomp)

def parse_game(game)

end

input.each do |line|
    game_id= line.chars[line.index(":")-1]

    topRed,tempRed,topGreen,tempGreen,topBlue,tempBlue=0,0,0,0,0,0

    p "Game #{game_id}"
    color_hash=Hash.new
    game_array=Array.new

    line.split(": ")[1].split("; ").each do |pull|
        pull.split(", ").each do |colors|
            game_array<<[colors.split(" ")[1],colors.split(" ")[0]]
            # color_hash[colors.split(" ")[1]]=colors.split(" ")[0]
        end
        # p "color hash: #{color_hash}"
        # game_array<<color_hash.to_a
        

        

    end
    # p topRed,topGreen, topBlue

    # p game_array

    # p "Red: #{pull.chars[pull.index("red")-2]}" unless pull.index("red").nil?
    # p "Green: #{pull.chars[pull.index("green")-2]}" unless pull.index("green").nil?
    # p "Blue: #{pull.chars[pull.index("blue")-2]}" unless pull.index("blue").nil?

    game_array.each do |pull|
        # p pull
        val = pull[1].to_i
        case pull[0]
        when "red"
            topRed = val if topRed<val
        when "green"
            topGreen = val if topGreen<val
        when "blue"
            topBlue = val if topBlue<val
        end        
    end
    p "TopRed: #{topRed} | Top Green: #{topGreen} | Top Blue: #{topBlue} "
end
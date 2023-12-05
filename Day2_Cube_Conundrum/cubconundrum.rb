Dir.chdir(File.dirname(__FILE__))
input=File.open("puzzleInput.txt").readlines.map(&:chomp)
# input=File.open("teststrings.txt").readlines.map(&:chomp)

$maxRed=12
$maxGreen=13
$maxBlue=14

sum=0

def parse_game(game)

end

input.each do |line|
    game_id= line.split(": ")[0].split(" ")[1]

    topRed,topGreen,topBlue,=0,0,0
    game_array=Array.new

    line.split(": ")[1].split("; ").each do |pull|
        pull.split(", ").each do |colors|
            game_array<<[colors.split(" ")[1],colors.split(" ")[0]]
        end
    end

    game_array.each do |pull|
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

    unless((topRed>$maxRed) || (topGreen>$maxGreen) || (topBlue>$maxBlue))
        p "Possible"
        sum+=game_id.to_i
    end
end

p sum
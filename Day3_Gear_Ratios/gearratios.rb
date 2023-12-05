Dir.chdir(File.dirname(__FILE__))
# input=File.open("puzzleInput.txt").readlines.map(&:chomp)
input=File.open("teststrings.txt").readlines.map(&:chomp)

$symbols = ["!","@","#","$","%","^","&","*","(",")","-","=","_","+","<",">","?"]

# Reused from day 1
def scan_string(string, regex)
    result = Array.new
    (0..string.length).each do |x|
        if (string[x..-1] =~ /^#{regex}/)
            result << [Regexp.last_match.to_s,x] 
        end
    end
    result
end

def find_symbol()

end


input.each do |line|
    p line

end

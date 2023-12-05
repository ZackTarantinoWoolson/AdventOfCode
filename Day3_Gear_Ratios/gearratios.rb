Dir.chdir(File.dirname(__FILE__))
# input=File.open("puzzleInput.txt").readlines.map(&:chomp)
input=File.open("teststrings.txt").readlines.map(&:chomp)

$symbols = ["!","@","#","$","%","&","*","-","=","_","+","<",">","?"]

# Reused from day 1
def scan_string(string, regex)
    result = Array.new
    (0..string.length).each do |x|
        if (string[x-1] =~ /[#{regex}]/)
            result << [Regexp.last_match.to_s,x] 
        end
    end
    result
end

def find_symbol_col(line,ind)
    sym_list = Array.new
    $symbols.each do |sym|
        scan = scan_string(line,sym)
        scan.each { |s| sym_list<< s[1] } unless (scan.empty?)
    end
    sym_list.sort_by{|k,v| v}
end

sym_table=Array.new

input.each_with_index do |line,ind|
    p line
    rc=Array.new # row and collumn of symbols

    rc<<ind
    rc<<find_symbol_col(line,ind)

    sym_table<<rc
end

p sym_table

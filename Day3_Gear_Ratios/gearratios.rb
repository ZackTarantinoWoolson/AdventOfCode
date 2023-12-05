Dir.chdir(File.dirname(__FILE__))
# input=File.open("puzzleInput.txt").readlines.map(&:chomp)
input=File.open("teststrings.txt").readlines.map(&:chomp)

# correct: 526404
# I got 507705

$part1_symbols = ["!","@","#","$","%","&","*","-","=","_","+","<",">","?","/"]
$part2_symbols = ["*"]

# Reused from day 1
def scan_string(string, regex)
    result = Array.new
    (0..string.length).each do |x|
        if (string[x-1] =~ /#{regex}/)
            result << [Regexp.last_match.to_s,x] 
        end
    end
    result
end

def find_number_col(line)
    num_list = Array.new
    num=""
    ind=0
    (0..line.length-1).each do |x|
        ch = line.chars[ind]
        unless ch.match(/[0-9]/).nil?
            num = is_next_char_num(line,ind)
            num_list << [num,ind+1] #increas index by 1 to make the it index1 instead of index0
            ind+=num.length
        else
            ind+=1
        end
        num=""
        break if ind+1>line.length
    end

    return num_list
end

def is_next_char_num(line,ind)
    number=line.chars[ind]
    while !line.chars[ind+1].match(/[0-9]/).nil?
        number += line.chars[ind+1]
        ind+=1
        break if ind+number.length>line.length
    end

    return number
end

def find_symbol_col(line, symbols)
    sym_list = Array.new
    symbols.each do |sym|
        scan = scan_string(line,"[#{sym}]")
        scan.each { |s| sym_list<< s[1] } unless (scan.empty?)
    end
    sym_list.sort_by{|k,v| v}
end

def find_neighbors(row,col,nums)
    numbers_to_return=Array.new
    line_total=0
    nums[1].each do |n|
        # p "Number: #{n[0]} | numbers index: #{n[1]} | Col: #{col}"
        if (([col-1,col,col+1].include?(n[1])) || ([col-1,col,col+1].include?(n[1]+n[0].length.to_i-1)))
            line_total+=n[0].to_i
        end
    end

    return line_total
end


#### Part 1

sym_table = Array.new
num_table = Array.new
all_numbers=Array.new

input.each_with_index do |line,ind|
    sym_rc=Array.new # row and collumn of symbols

    sym_rc<<ind
    sym_rc<<find_symbol_col(line,$part1_symbols)
    sym_table<<sym_rc unless sym_rc[1].empty?

    num_table<<[ind,find_number_col(line)]
end

sym_table.each do |s|
    row = s[0]
    cols= s[1]

    cols.each do |c|
        all_numbers<<find_neighbors(row-1,c,num_table[row-1]) unless num_table[row-1].nil?
        all_numbers<<find_neighbors(row,c,num_table[row])
        all_numbers<<find_neighbors(row+1,c,num_table[row+1]) unless num_table[row+1].nil?
    end
end

p "Part 1: #{all_numbers.sum}"


#### Part 2

sym_table.clear
num_table.clear
all_numbers.clear

input.each_with_index do |line,ind|
    sym_rc=Array.new # row and collumn of symbols

    sym_rc<<ind
    sym_rc<<find_symbol_col(line,$part2_symbols)
    sym_table<<sym_rc unless sym_rc[1].empty?

    num_table<<[ind,find_number_col(line)]
end

p sym_table,num_table

sym_table.each do |s|
    symbols_neighbors=Array.new
    row = s[0]
    cols= s[1]

    cols.each do |c|
        symbols_neighbors<<find_neighbors(row-1,c,num_table[row-1]) unless num_table[row-1].nil?
        symbols_neighbors<<find_neighbors(row,c,num_table[row]) unless num_table[row].nil?
        symbols_neighbors<<find_neighbors(row+1,c,num_table[row+1]) unless num_table[row+1].nil?
        symbols_neighbors.delete(0) # remove any zeros
    end

    # p symbols_neighbors
    unless symbols_neighbors.size!=2
        all_numbers << symbols_neighbors[0]*symbols_neighbors[1]
    end
end

p "Part 2: #{all_numbers.sum}"
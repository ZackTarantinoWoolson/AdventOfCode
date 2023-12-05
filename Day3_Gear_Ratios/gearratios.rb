Dir.chdir(File.dirname(__FILE__))
# input=File.open("puzzleInput.txt").readlines.map(&:chomp)
input=File.open("teststrings.txt").readlines.map(&:chomp)

$symbols = ["!","@","#","$","%","&","*","-","=","_","+","<",">","?"]

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
        # p ind, ch
        unless ch.match(/[0-9]/).nil?
            num = is_next_char_num(line,ind)
            num_list << [num,ind]
            # p num
            ind+=num.length
        else
            ind+=1
        end

        # ind+=num.length
        # ind+=1
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
    end

    return number
end

def find_symbol_col(line)
    sym_list = Array.new
    $symbols.each do |sym|
        scan = scan_string(line,"[#{sym}]")
        scan.each { |s| sym_list<< s[1] } unless (scan.empty?)
    end
    sym_list.sort_by{|k,v| v}
end

sym_table = Array.new
num_table = Array.new

input.each_with_index do |line,ind|
    p line
    sym_rc=Array.new # row and collumn of symbols

    sym_rc<<ind
    sym_rc<<find_symbol_col(line)
    sym_table<<sym_rc unless sym_rc[1].empty?


    num_table<<[ind,find_number_col(line)]
end

p sym_table
p num_table


Dir.chdir(File.dirname(__FILE__))
input=File.open("puzzleInput.txt").readlines.map(&:chomp)
# input=File.open("teststrings.txt").readlines.map(&:chomp)

# 55447
# 54706

$num_strings = ["zero","one","two","three","four","five","six","seven","eight","nine"]
$num_nums = ["0","1","2","3","4","5","6","7","8","9"]
$all_nums = $num_strings+$num_nums

def scan_string(string, regex)
    result = Array.new
    (0..string.length).each do |x|
        if (string[x..-1] =~ /^#{regex}/)
            result << [Regexp.last_match.to_s,x] 
        end
    end
    result
end

def find_numbers(line)
    num_index = Array.new # ["num", index]

    # Part 1 : Just look for ints
    $num_nums.each do |num|
        temp = scan_string(line,num)
        temp.each { |t| num_index<< t } unless (temp.empty?)
    end

    num_index.sort_by{|k,v| v}
end

def convert_strings(num)
    if($num_nums.include?(num[0]))
        return num[0]
    end
    $num_strings.each_with_index do |ele,index|
        if (num[0]==ele)
            return index
        end
    end
end

final_num = 0

input.each do |line|
    nums_in_line = find_numbers(line)

    sub_total = convert_strings(nums_in_line.first).to_s
    sub_total += convert_strings(nums_in_line.last).to_s

    final_num += sub_total.to_i
end

p final_num

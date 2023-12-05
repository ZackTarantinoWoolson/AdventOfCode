Dir.chdir(File.dirname(__FILE__))
input=File.open("teststrings.txt").readlines.map(&:chomp)

# 54706

$num_strings = ["zero","one","two","three","four","five","six","seven","eight","nine"]
$nums = ["0","1","2","3","4","5","6","7","8","9"]

def find_numbers(line)
    num_index = Hash.new # {}"num" => index}
    $num_strings.each do |num|
        ind = line.index(num)
        unless ind.nil?
            num_index[num]=ind
        end
    end
    $nums.each do |num|
        ind = line.index(num)
        unless ind.nil?
            num_index[num]=ind
        end
    end
    num_index.sort_by{|k,v| v}
end

def convert_strings(num)
    if($nums.include?(num[0]))
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
    p nums_in_line

    p "#{nums_in_line.first} | #{nums_in_line.last}"

    sub_total = convert_strings(nums_in_line.first).to_s
    sub_total += convert_strings(nums_in_line.last).to_s
    p sub_total
    final_num += sub_total.to_i
end

p final_num

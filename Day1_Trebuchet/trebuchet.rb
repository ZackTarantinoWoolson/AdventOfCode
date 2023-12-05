# test_strings = ["kjrqmzv9mmtxhgvsevenhvq7","four2tszbgmxpbvninebxns6nineqbqzgjpmpqr",
# "rkzlnmzgnk91zckqprrptnthreefourtwo","fouronevzkbnzm6seven47",
# "zphgdcznqsm2","4gjnmxtrbflgp71","4sqvv1cnpn"]

test_strings=["1abc2","pqr3stu8vwx","a1b2c3d4e5f","treb7uchet"]

# test_strings = ["seven5trmnqnqgqprkdkxcsrtmzjccgrtbklnhnfive"]


Dir.chdir(File.dirname(__FILE__))
input=File.open("puzzleInput.txt").readlines.map(&:chomp)

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

test_strings.each do |line|
    # p line
    nums_in_line = find_numbers(line)
    # p "first #{nums_in_line.first} | last: #{nums_in_line.last}"

    sub_total = convert_strings(nums_in_line.first).to_s
    sub_total += convert_strings(nums_in_line.last).to_s
    final_num += sub_total.to_i
end

p final_num

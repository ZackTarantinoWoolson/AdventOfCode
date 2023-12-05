# test_strings = ["kjrqmzv9mmtxhgvsevenhvq7","four2tszbgmxpbvninebxns6nineqbqzgjpmpqr",
# "rkzlnmzgnk91zckqprrptnthreefourtwo","fouronevzkbnzm6seven47",
# "zphgdcznqsm2","4gjnmxtrbflgp71","4sqvv1cnpn"]
test_strings = ["kjrqmzv9mmtxhgvsevenhvq7"]


Dir.chdir(File.dirname(__FILE__))
input=File.open("puzzleInput.txt").readlines.map(&:chomp)

$num_strings = ["zero","one","two","three","four","five","six","seven","eight","nine"]
$nums = ["0","1","2","3","4","5","6","7","8","9"]

def find_numbers(line)
    num_index = Hash.new
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

    p num_index.sort_by{|k,v| v}
end

test_strings.each do |line|
    p line
    nums_in_line = find_numbers(line)
end

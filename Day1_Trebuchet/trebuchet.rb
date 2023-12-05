test_strings = ["kjrqmzv9mmtxhgvsevenhvq7","four2tszbgmxpbvninebxns6nineqbqzgjpmpqr",
"rkzlnmzgnk91zckqprrptnthreefourtwo","fouronevzkbnzm6seven47",
"zphgdcznqsm2","4gjnmxtrbflgp71","4sqvv1cnpn"]


Dir.chdir(File.dirname(__FILE__))
input=File.open("puzzleInput.txt").readlines.map(&:chomp)

$replace_hash = ["zero","one","two","three","four","five","six","seven","eight","nine"]

def find_numbers(line)
    $replace_hash.each do |num|
        p line.index(num)
    end
end

test_strings.each do |line|
    p line
    find_numbers(line)
    gets
end

Dir.chdir(File.dirname(__FILE__))
$input=File.open("puzzleInput.txt").readlines.map(&:chomp)
# $input=File.open("teststrings.txt").readlines.map(&:chomp)

def build_maps(x)
    mapped_numbers=Array.new
    
    (x..$input.length).each do |r|
        temp=Array.new
        break if $input[r].nil? || !$input[r].scan("map").empty? || $input[r].empty?
        
        $input[r].split(" ").each {|x| temp<<x.to_i}
        mapped_numbers<<temp
    end
    mapped_numbers
end

def source_to_destination(source_to_dest_map, source)
    source_to_dest_map.each do |x|
        if (source>=x[1] && source<=x[1]+x[2])
            return (source-x[1])+x[0]
        end
    end
    return source
end
def source_to_destination2(source_to_dest_map, source)
    source_to_dest_map.each do |x|
        
        if (source>=x[0] && source<=x[0]+x[2])
            p "row that worked: #{x}"
            return (source-x[0])+x[1]
        end
    end
    return source
end


initial_seeds=Array.new
$input[0].split(": ")[1].split(" ").each {|x| initial_seeds<<x.to_i}

seed_to_soil_map=Array.new
soil_to_fertilizer_map=Array.new
fertilizer_to_water_map=Array.new
water_to_light_map=Array.new
light_to_temperature_map=Array.new
temperature_to_humidity_map=Array.new
humidity_to_location_map=Array.new
all_locations = Array.new

$input.each_with_index do |row,x|
    next if row.empty? || !row.scan("seeds:").empty?
    if !row.scan("map").empty?
        case row.split(" ")[0]
        when "seed-to-soil"
            seed_to_soil_map=build_maps(x+1)
        when "soil-to-fertilizer"
            soil_to_fertilizer_map=build_maps(x+1)
        when "fertilizer-to-water"
            fertilizer_to_water_map=build_maps(x+1)
        when "water-to-light"
            water_to_light_map=build_maps(x+1)
        when "light-to-temperature"
            light_to_temperature_map=build_maps(x+1)
        when "temperature-to-humidity"
            temperature_to_humidity_map=build_maps(x+1)
        when "humidity-to-location"
            humidity_to_location_map=build_maps(x+1)
        end
    end
end

initial_seeds.each do |seed|
    # p seed
    soil=source_to_destination(seed_to_soil_map, seed)
    fertilizer=source_to_destination(soil_to_fertilizer_map,soil)
    water=source_to_destination(fertilizer_to_water_map,fertilizer)
    light=source_to_destination(water_to_light_map,water)
    temperature=source_to_destination(light_to_temperature_map,light)
    humidity=source_to_destination(temperature_to_humidity_map,temperature)
    location=source_to_destination(humidity_to_location_map,humidity)
    all_locations<<location
    # p location
end

p "Part 1: #{all_locations.sort[0]}"

### Part 2:
all_locations.clear
new_seeds=Array.new


# (0..initial_seeds.length-1).step(2) do |x|
#     seed= initial_seeds[x]
#     range=initial_seeds[x+1]
#     (0..range-1).each do |y|
#         new_seeds<<seed+y
#     end
# end

# new_seeds.each do |seed|
#     p seed
#     soil=source_to_destination(seed_to_soil_map, seed)
#     fertilizer=source_to_destination(soil_to_fertilizer_map,soil)
#     water=source_to_destination(fertilizer_to_water_map,fertilizer)
#     light=source_to_destination(water_to_light_map,water)
#     temperature=source_to_destination(light_to_temperature_map,light)
#     humidity=source_to_destination(temperature_to_humidity_map,temperature)
#     location=source_to_destination(humidity_to_location_map,humidity)
#     all_locations<<location
# end

# (0..initial_seeds.length-1).step(2) do |x|
#     new_seeds<< initial_seeds[x]
# end
# p new_seeds.sort.first
# new_seeds.clear

# (0..initial_seeds.length-1).step(2) do |x|
#     new_seeds<< initial_seeds[x]+initial_seeds[x+1]
# end
# p new_seeds.sort.last

# (311881326..4016268358).each do |seed|
#     p seed if seed%10000000==0

# end

def thing(initial_seeds,seed)
    (0..initial_seeds.length-1).step(2) do |x|
        # p "#{initial_seeds[x]} and #{initial_seeds[x]+initial_seeds[x+1]}"
        if (seed>=initial_seeds[x] && seed<=(initial_seeds[x]+initial_seeds[x+1]))
            p "in range of #{initial_seeds[x]} and #{initial_seeds[x]+initial_seeds[x+1]}"
            return true
        end
    end
    return false
end

final_location =-1
final_seed=-1
# reverse search
(0..327948845).each do |loc|
    # loc = 9622622
    # p loc
    p loc if loc%1000000==0
    humidity=source_to_destination2(humidity_to_location_map,loc)
    # p humidity
    temperature=source_to_destination2(temperature_to_humidity_map,humidity)
    light=source_to_destination2(light_to_temperature_map,temperature)
    water=source_to_destination2(water_to_light_map,light)
    fertilizer=source_to_destination2(fertilizer_to_water_map,water)
    soil=source_to_destination2(soil_to_fertilizer_map,fertilizer)
    seed=source_to_destination2(seed_to_soil_map, soil)
    # seed = 565778306
    # loc = 510109797 == seed = 13548942
    # p seed
    # p thing(initial_seeds,seed)
    if thing(initial_seeds,seed)
        final_location=loc
        final_seed=seed
        break
    end
    # gets
    # 2557516811
end


#311881326 is the lowest
#4016268358 is the highest seed number

p "Part 2: #{final_location} | #{final_seed}"


# actual answer is 9622622


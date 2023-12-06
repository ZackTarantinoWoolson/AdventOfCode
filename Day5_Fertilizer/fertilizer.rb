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
    soil=source_to_destination(seed_to_soil_map, seed)
    fertilizer=source_to_destination(soil_to_fertilizer_map,soil)
    water=source_to_destination(fertilizer_to_water_map,fertilizer)
    light=source_to_destination(water_to_light_map,water)
    temperature=source_to_destination(light_to_temperature_map,light)
    humidity=source_to_destination(temperature_to_humidity_map,temperature)
    location=source_to_destination(humidity_to_location_map,humidity)
    all_locations<<location
end

p "Part 1: #{all_locations.sort[0]}"

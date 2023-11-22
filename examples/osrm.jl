using HTTP, JSON

if length(ARGS) < 1
    println("This short program needs the OSRM server's ip address and his port.")
    println("Usage: julia osrm_example.jl <xx.xx.xx.xx> <xxxx>")
    println("Example: julia main.jl 127.0.0.1 50000")
else

    println("The program will ask the OSRM server $(ARGS[1]):$(ARGS[2]) for the shortest distance between two coordinates that you will provide soon.")

    function get_shortest_distance(srv, pt, from, to)

        url = "http://$(srv):$(pt)/route/v1/driving/$(from[1]),$(from[2]);$(to[1]),$(to[2])?overview=false"

        try
            response = HTTP.get(url)
        catch e
            @error "Connection error"
            println("Error connecting to the server: ", e)
            return
        end

        try
            parsed_response = JSON.parse(String(response.body))
        catch e
            @error "JSON parsing error"
            println("Error parsing the server response: ", e)
            return
        end

        try
            shortest_distance = parsed_response["routes"][1]["distance"]
        catch e
            @error "Distance extraction error"
            println("Error extracting the shortest distance from the server response: ", e)
            return
        end

        return shortest_distance
    end

    println("This short program needs two valid coordinates to calculate the shortest distance between them.")
    println("The coordinates must be in the format: latitude,longitude")
    println("Example: 46.2173557,6.0882657")

    println("Enter the 'from' coordinates (latitude,longitude): ")

    from = try
        split(readline(), ",") |> x -> map(y -> parse(Float64, y), x)
    catch e
        @error "Fill out error"
        println("Error parsing the 'from' coordinates: ", e)
        return
    end

    println("Enter the 'to' coordinates (latitude,longitude): ")

    to = try
        split(readline(), ",") |> x -> map(y -> parse(Float64, y), x)
    catch e
        @error "Fill out error"
        println("Error parsing the 'to' coordinates: ", e)
        return
    end

    distance = get_shortest_distance(ARGS[1], ARGS[2], from, to)

    if distance !== nothing
        println("The shortest distance is: ", distance, " meters")
    end
end
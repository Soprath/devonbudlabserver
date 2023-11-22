function writing(filename::AbstractString, start::Int64, stop::Int64, sleep_time::Int64)
    out = "starting to write to $(filename) every $(sleep_time) seconds from $(start) to $(stop)"
    @info out
    println(out)
    i = start
    while true
        out = "write the step number $(i)"
        @info out
        println(out)
        open(filename, "a") do file
            write(file, "Nouvelle ligne en position : $(i)\n")
        end
        sleep(sleep_time)  # Sleep for 60 seconds (1 minute)
        i += 1
        if i == stop + 1
            break
        end
    end
end

function check_and_remove(filename::AbstractString)
    if isfile(filename)
        rm(filename)
        println("File $filename has been removed.")
    else
        println("File $filename does not exist.")
    end
end

if length(ARGS) < 1
    println("Ce script d'exemple nécessite les paramètres suivants :")
    println("Paramètre 1 <String> : le fichier à créer;")
    println("Paramètre 2 <Integer> : le nombre de départ;")
    println("Paramètre 3 <Integer> : le nombre de fin;")
    println("Paramètre 4 <Integer> : le temps (seconde) entre chaque écriture;")
    exit(1)
else
    #   Récupérer les paramètres
    @info "le script est correctement lancé, début du traitement..."
    p = Any[ARGS[1], parse(Int64, ARGS[2]), parse(Int64, ARGS[3]), parse(Int64, ARGS[4])]
    check_and_remove(p[1])
    writing(p[1], p[2], p[3], p[4])
    @info "fin du traitement, aurevoir!"
end
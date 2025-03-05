digraph a_nice_graph
{
    node [fontname="Helvetica", shape="box", width=4, fillcolor="LightSalmon", style="filled"]
    
    assessed [label="Assessed for Eligibility (n = )"]
    randomized [label="Randomized (n = )"]
    allocatedA [label="Allocated to intervention A (n = )"]
    allocatedB [label="Allocated to intervention B (n = )"]
    lostA [label="Lost to follow-up (n = )"]
    lostB [label="Lost to follow-up (n = )"]
    analyzedA [label="Analyzed (n = )"]
    analyzedB [label="Analyzed (n = )"]
    blank [label="", width=0.01, height=0.01]
    excluded [label="Excluded (n = )"]

    { rank = same; blank excluded }

    assessed -> blank [dir=none]
    blank -> excluded [minlen=3]
    blank -> randomized
    randomized -> {allocatedA allocatedB}
    allocatedA -> lostA
    allocatedB -> lostB
    lostA -> analyzedA
    lostB -> analyzedB
}

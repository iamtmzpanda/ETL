// function
val
def

// exception 
try {
    block
} catch {
    case pattern if guard => statements
    case pattern => statements
} finally {
    block
}

// case class
// pattern matching 


// collection


// map
// foreach
""" 
foreach iterates over a list and performs some operation with side effects to each list member (such as saving each one to the database for example)
map iterates over a list, transforms each member of that list, and returns another list of the same size with the transformed members (such as converting a list of strings to uppercase)
"""
val donuts4: Seq[String] = donuts3.map {
 case donut: String => donut + " Donut"
 case None => "Unknown Donut"
}


// reflection

// dependency injection

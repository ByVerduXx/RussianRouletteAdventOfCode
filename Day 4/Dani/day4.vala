using Gee;

public static void main(){
	var file = FileStream.open("input.txt", "r");
	
	string line = file.read_line();
    //create an array to store the lines
    var lines = new ArrayList<string> ();

	while (line != null){
        //add the line to the array
        lines.add(line);
		line = file.read_line();
	}

    int counter = 0;
    int counter2 = 0;
    for (int i = 0; i < lines.size; i++){
        //split the line between ,
        var splitted = lines[i].split(",");
        var elf1 = splitted[0].split("-");
        var elf2 = splitted[1].split("-");
        if (int.parse(elf1[0]) <= int.parse(elf2[0]) && int.parse(elf1[1]) >= int.parse(elf2[1])){
            counter++;
            counter2++;
        }
        else if (int.parse(elf1[0]) >= int.parse(elf2[0]) && int.parse(elf1[1]) <= int.parse(elf2[1])){
            counter++;
            counter2++;
        }
        //Part 2
        else if (int.parse(elf1[0]) <= int.parse(elf2[0]) && int.parse(elf1[1]) >= int.parse(elf2[0])){
            counter2++;
        }
        else if (int.parse(elf1[0]) >= int.parse(elf2[0]) && int.parse(elf1[0]) <= int.parse(elf2[1])){
            counter2++;
        }
        
    }

    stdout.printf("%d\n", counter);
    stdout.printf("%d\n", counter2);
    
}
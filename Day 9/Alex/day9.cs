using System;
using System.Collections.Generic;


public class Day9 {

    public static List<int> moveTail(List<int> head_pos, List<int> tail_pos){

        int d_x = head_pos[0] - tail_pos[0];
        int d_y = head_pos[1] - tail_pos[1];

        if (!(Math.Abs(d_x) <= 1 && Math.Abs(d_y) <= 1)){
            tail_pos[0] += Math.Sign(d_x);
            tail_pos[1] += Math.Sign(d_y);
        }

        return tail_pos;
    }

    public static void expandGrids(List<List<string>> grid, List<List<List<string>>> visited, List<int> head_pos, List<List<int>> tail_pos){
        if ((head_pos[0] >= 0 && head_pos[0] < grid.Count) && (head_pos[1] >= 0 && head_pos[1] < grid[0].Count))
            return;
        else{
            if (head_pos[0] < 0){
                // Expand grids
                grid.Insert(0, new List<string>());
                for (int i = 0; i < visited.Count; i++)
                    visited[i].Insert(0, new List<string>());

                for (int i = 0; i < grid[grid.Count-1].Count; i++){
                    grid[0].Add(".");
                    for (int j = 0; j < visited.Count; j++)
                        visited[j][0].Add(".");
                }

                // Update rope positions
                head_pos[0] += 1;
                for (int i = 0; i < tail_pos.Count; i++)
                    tail_pos[i][0] += 1;
            } else if (head_pos[0] >= grid.Count){
                // Expand grids
                grid.Add(new List<string>());
                for (int i = 0; i < visited.Count; i++)
                    visited[i].Add(new List<string>());

                int last_row = grid.Count-1;
                for (int i = 0; i < grid[0].Count; i++){
                    grid[last_row].Add(".");
                    for (int j = 0; j < visited.Count; j++)
                        visited[j][last_row].Add(".");
                }
            }
            
            if (head_pos[1] < 0){
                // Expand grids
                for (int i = 0; i < grid.Count; i++){
                    grid[i].Insert(0, ".");
                    for (int j = 0; j < visited.Count; j++)
                        visited[j][i].Insert(0, ".");
                }

                // Update rope positions
                head_pos[1] += 1;
                for (int i = 0; i < tail_pos.Count; i++)
                    tail_pos[i][1] += 1;
            } else if (head_pos[1] >= grid[0].Count){
                // Expand grids
                for (int i = 0; i < grid.Count; i++){
                    grid[i].Add(".");
                    for (int j = 0; j < visited.Count; j++)
                        visited[j][i].Add(".");
                }
            }
        }
    }

    public static void moveHead(List<int> head_pos, List<List<int>> tail_pos, string direction, int distance, List<List<string>> grid, List<List<List<string>>> visited){

        int d_x = 0;
        int d_y = 0;

        // Interprete direction
        switch (direction)
        {
            case "U":
                d_x = +1;
                break;
            case "D":
                d_x = -1;
                break;
            case "L":
                d_y = -1;
                break;
            case "R":
                d_y = +1;
                break;
            default:
                break;
        }

        // Move head
        for (int i = 0; i < distance; i++){
            head_pos[0] += d_x;
            head_pos[1] += d_y;
            expandGrids(grid, visited, head_pos, tail_pos);
            tail_pos[0] = moveTail(head_pos, tail_pos[0]);
            for (int j = 1; j < tail_pos.Count; j++)
                tail_pos[j] = moveTail(tail_pos[j-1], tail_pos[j]);
            visited[0][tail_pos[0][0]][tail_pos[0][1]] = "#";
            visited[1][tail_pos[8][0]][tail_pos[8][1]] = "#";
        }
    }

    public static List<List<List<string>>> simulate(){
        List<List<List<string>>> visited = new List<List<List<string>>>();
        List<List<string>> grid = new List<List<string>>();

        // Initialize grid
        grid.Add(new List<string>());
        grid[0].Add("H");

        // Part 1 result
        visited.Add(new List<List<string>>());
        visited[0].Add(new List<string>());
        visited[0][0].Add("#");

        // Part 2 result
        visited.Add(new List<List<string>>());
        visited[1].Add(new List<string>());
        visited[1][0].Add("#");

        // Head position
        List<int> head_pos = new List<int>();
        head_pos.Add(grid.Count-1);
        head_pos.Add(0);

        List<List<int>> tail_pos = new List<List<int>>();
        for (int i = 0; i < 9; i++)
            tail_pos.Add(new List<int>{grid.Count-1, 0});

        // printGrid(grid, head_pos, tail_pos[8]);

        string input = Console.ReadLine();
        while (input!=null) {
            // Ask for input
            string[] split_input = input.Split(' ');
            string direction = split_input[0];
            int distance = Convert.ToInt32(split_input[1].ToString());

            // Calculate new positions
            moveHead(head_pos, tail_pos, direction, distance, grid, visited);

            // printGrid(visited[1], head_pos, tail_pos[8]);

            input = Console.ReadLine();
        }

        return visited;
    }

    public static void printGrid(List<List<string>> grid, List<int> head_pos, List<int> tail_pos){
        Console.WriteLine("==================================");
        for (int i = 0; i < grid.Count; i++){
            for (int j = 0; j < grid[i].Count; j++){
                if (i == head_pos[0] && j == head_pos[1])
                    Console.Write("H");
                else if (i == tail_pos[0] && j == tail_pos[1])
                    Console.Write("T");
                else 
                    Console.Write(grid[i][j]);
            }
            Console.WriteLine();
        }
        Console.WriteLine("==================================");
    }

    public static int countVisited(List<List<string>> visited){
        int count = 0;
        for (int i = 0; i < visited.Count; i++){
            for (int j = 0; j < visited[i].Count; j++){
                if (visited[i][j] == "#")
                    count++;
            }
        }
        return count;
    }

	static public void Main()
	{

        // Part 1
        List<List<List<string>>> visited = simulate();
        
        printGrid(visited[0], new List<int>() {0, 0}, new List<int>() {0, 0});
        Console.WriteLine("Part 1: " + countVisited(visited[0]) + " visited squares");

        // Part 2
        printGrid(visited[1], new List<int>() {0, 0}, new List<int>() {0, 0});
        Console.WriteLine("Part 2: " + countVisited(visited[1]) + " visited squares");
	}
}

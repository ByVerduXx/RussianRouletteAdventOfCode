using System;
using System.Collections.Generic;


public class Day8 {
    public static List<List<int>> readInput(){
        List<List<int>> grid = new List<List<int>>();

        string input = Console.ReadLine();
        while (input!=null) {
            grid.Add(new List<int>());
            for (int i = 0; i < input.Length; i++){
                grid[grid.Count-1].Add(Convert.ToInt32(input[i].ToString()));
            }
            input = Console.ReadLine();
        }

        return grid;
    }

    public static void printGrid(List<List<int>> grid){
        for (int i = 0; i < grid.Count; i++){
            for (int j = 0; j < grid[i].Count; j++){
                Console.Write(grid[i][j]);
            }
            Console.WriteLine();
        }
    }

    public static bool visibleFrom(List<List<int>> grid, int height, int i, int j, int di, int dj){
        if (i+di < 0 || i+di >= grid.Count || j+dj < 0 || j+dj >= grid[i].Count)
            return true;
        if (height <= grid[i+di][j+dj])
            return false;
        return visibleFrom(grid, height, i+di, j+dj, di, dj);
    }
    
    public static bool isVisible(List<List<int>> grid, int i, int j){
        if ((i == 0 || i == grid.Count-1) || (j == 0 || j == grid[i].Count-1))
            return true;
        int height = grid[i][j];
        return visibleFrom(grid, height, i, j, -1, 0) ||
               visibleFrom(grid, height, i, j, 1, 0) ||
               visibleFrom(grid, height, i, j, 0, -1) ||
               visibleFrom(grid, height, i, j, 0, 1);
    }

    /**
      * Each cell is visible from outside the grid if there is any way to get to it from outside the grid.
      **/
    public static List<List<int>> visibleMatrix(List<List<int>> grid) {
        List<List<int>> visible = new List<List<int>>();
        for (int i = 0; i < grid.Count; i++){
            visible.Add(new List<int>());
            for (int j = 0; j < grid[i].Count; j++){
                visible[i].Add(0);
            }
        }

        for (int i = 0; i < grid.Count; i++){
            for (int j = 0; j < grid[i].Count; j++){
                if (isVisible(grid, i, j)){
                    visible[i][j] = 1;
                }
            }
        }

        return visible;
    }

    public static int countVisible(List<List<int>> grid){
        int count = 0;
        for (int i = 0; i < grid.Count; i++){
            for (int j = 0; j < grid[i].Count; j++){
                if (grid[i][j] == 1)
                    count++;
            }
        }
        return count;
    }

    public static int viewing_distance(List<List<int>> grid, int height, int i, int j, int di, int dj){
        if (i+di < 0 || i+di >= grid.Count || j+dj < 0 || j+dj >= grid[i].Count)
            return 0;
        if (height <= grid[i+di][j+dj])
            return 1;
        return 1 + viewing_distance(grid, height, i+di, j+dj, di, dj);
    }

    public static int scenic_score(List<List<int>> grid, int i, int j){
        return viewing_distance(grid, grid[i][j], i, j, -1, 0) *
               viewing_distance(grid, grid[i][j], i, j, 1, 0) *
               viewing_distance(grid, grid[i][j], i, j, 0, -1) *
               viewing_distance(grid, grid[i][j], i, j, 0, 1);
    }

    public static List<List<int>> scenicMatrix(List<List<int>> grid){
        List<List<int>> scenic = new List<List<int>>();
        for (int i = 0; i < grid.Count; i++){
            scenic.Add(new List<int>());
            for (int j = 0; j < grid[i].Count; j++){
                scenic[i].Add(scenic_score(grid, i, j));
            }
        }

        return scenic;
    }

    public static int maxValue(List<List<int>> grid){
        int max = 0;
        for (int i = 0; i < grid.Count; i++){
            for (int j = 0; j < grid[i].Count; j++){
                if (grid[i][j] >= max)
                    max = grid[i][j];
            }
        }
        return max;
    }

	static public void Main()
	{
        List<List<int>> grid = readInput();

        // Part 1
        List<List<int>> visible = visibleMatrix(grid);
        //printGrid(visible);
        Console.WriteLine("There are {0} visible trees.", countVisible(visible));

        // Part 2
        List<List<int>> scenic = scenicMatrix(grid);
        //printGrid(scenic);
        Console.WriteLine("The highest scenic score is {0}.", maxValue(scenic));

	}
}

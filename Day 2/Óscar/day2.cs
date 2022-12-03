// day 2
namespace Day2
{
    class Day {         
        static void Main(string[] args)
        {
            int[] resultados = {0,0};
            string[] lines = System.IO.File.ReadAllLines(@".\input2.txt");
            char jugador, enemigo;
            foreach (string line in lines)
            {
                jugador = line[2];
                enemigo = line[0];
                if (jugador == 'X') resultados[0]+=0;
                else if(jugador == 'Y') resultados[0]+=3;
                else if (jugador == 'Z') resultados[0]+=6;

                if(jugador == 'X' && enemigo == 'A')      resultados[0] += 3;
                else if(jugador == 'X' && enemigo == 'B') resultados[0] += 1;
                else if(jugador == 'X' && enemigo == 'C') resultados[0] += 2;
                else if(jugador == 'Y' && enemigo == 'A') resultados[0] += 1;
                else if(jugador == 'Y' && enemigo == 'B') resultados[0] += 2;
                else if(jugador == 'Y' && enemigo == 'C') resultados[0] += 3;
                else if(jugador == 'Z' && enemigo == 'A') resultados[0] += 2;
                else if(jugador == 'Z' && enemigo == 'B') resultados[0] += 3;
                else if(jugador == 'Z' && enemigo == 'C') resultados[0] += 1;
            }
            Console.WriteLine("El jugador 1 ha obtenido {0} puntos", resultados[0]);
        }
    }
}
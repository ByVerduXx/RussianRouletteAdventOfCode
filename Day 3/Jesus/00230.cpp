#include <iostream>
#include <bits/stdc++.h>
#include <string>
//#include <regex>

// int main()
// {
//     std::string line;
//     std::set<char> a1;
//     std::set<char> a2;
//     int sum = 0;
//     while (std::getline(std::cin, line))
//     {   
//         std::string part1 = line.substr(0, line.length()/2);
//         std::string part2 = line.substr(line.length()/2, line.length());
//         for (char &c : part1)
//         {
//             a1.insert(c);
//         }
//         for (char &c : part2)
//         {
//             a2.insert(c);
//         }

//         // Compare the two sets and get the common elements
//         std::set<char> intersect;
//         std::set_intersection(a1.begin(), a1.end(), a2.begin(), a2.end(), std::inserter(intersect, intersect.begin()));
        
//         // Print the elements of the intersection
//         for (auto it = intersect.begin(); it != intersect.end(); ++it)
//         {
//             if (*it < 'a') {
//                 sum += (*it - 'A' + 1 + 26);
//                 std::cout << (*it - 'A' + 1 + 26);
//             } else {
//                 sum += (*it - 'a' + 1);
//                 std::cout << (*it - 'a' + 1);
//             }
            
//         }
//         std::cout << std::endl;
//         a1.clear();
//         a2.clear();

//         intersect.clear();
//     }
//     std::cout << sum << std::endl;
    
// }

// PART 2


int main()
{
    std::string line1;
    std::set<char> a1;
    std::set<char> a2;
    std::set<char> a3;

    int sum = 0;
    while (std::getline(std::cin, line1))
    {   
        std::string line2;
        std::getline(std::cin, line2);
        std::string line3;
        std::getline(std::cin, line3);

        for (char &c : line1)
        {
            a1.insert(c);
        }
        for (char &c : line2)
        {
            a2.insert(c);
        }
        for (char &c : line3)
        {
            a3.insert(c);
        }

        // Compare the 3 sets and get the common elements
        std::set<char> intersectAux;
        std::set_intersection(a1.begin(), a1.end(), a2.begin(), a2.end(), std::inserter(intersectAux, intersectAux.begin()));
        std::set<char> intersect;
        std::set_intersection(intersectAux.begin(), intersectAux.end(), a3.begin(), a3.end(), std::inserter(intersect, intersect.begin()));


        
        // Print the elements of the intersection
        for (auto it = intersect.begin(); it != intersect.end(); ++it)
        {   
            if (*it < 'a') {
                sum += (*it - 'A' + 1 + 26);
                std::cout << (*it - 'A' + 1 + 26);
            } else {
                sum += (*it - 'a' + 1);
                std::cout << (*it - 'a' + 1);
            }
            
        }
        std::cout << std::endl;
        a1.clear();
        a2.clear();
        a3.clear();

        intersectAux.clear();
        intersect.clear();
    }
    std::cout << sum << std::endl;
    
}

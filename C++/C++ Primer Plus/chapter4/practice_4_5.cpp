#include <iostream>
struct CandyBar{
    char brand[20];
    float weight;
    int Calorie;
};

int main()
{
    using namespace std;
    CandyBar snack = {"Mocha Munch", 2.3, 350};
    cout << "Brand: " << snack.brand << " \n";
    cout << "Weight: " << snack.weight << " \n";
    cout << "Calorie: " << snack.Calorie << " \n" << endl;

    CandyBar threeTypes[3] = {
        {"aa",2.1,222},
        {"bb",3.5,123},
        {"cc",4.1,345}
    };
    cout << threeTypes[1].brand << " " << threeTypes[1].weight << endl;
    CandyBar * aThreeTypes = new CandyBar[3];
    *(aThreeTypes+2) = threeTypes[2]; // OK
    *(aThreeTypes+2) = CandyBar{"cc",4.1,345}; // Not OK, now it's Ok.
    cout << aThreeTypes[2].brand << endl;
    delete [] aThreeTypes;
    cin.get();
    return 0;
}
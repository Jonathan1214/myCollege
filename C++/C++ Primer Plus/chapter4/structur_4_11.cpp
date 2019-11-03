#include <iostream>
struct inflatable {
    char name[20];
    float volume;
    double price;
};

int main()
{
    using namespace std;
    inflatable guest = {
        "Glorious Gloria",
        1.88,
        29.99
    };
    // some implementations require using
    // static inflatable guest =
    inflatable pal = {
        "Audacious Arthur",
        3.12,
        32.99
    };
    cout << "Expand your guest list with" << guest.name;
    cout << " and " << pal.name << "!\n";
    cout << "You can have both for $";
    cout << guest.price + pal.price << "!\n";

    cin.get();
    return 0;
}
#include <stdio.h>


class Car {
public:
	Car() { }
	
	virtual void Honk() = 0;
};


class RedCar : public Car {
public:
	RedCar() { }
	
	virtual void Honk();
};


void RedCar::Honk() {
	printf( "Honk!\n" );
}


int main( int argc, char *argv[] ) {
	RedCar mycar;
	mycar.Honk();
	return 0;
}

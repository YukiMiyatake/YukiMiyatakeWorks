#include<iostream>


 using namespace std;


 template<class T>
 class Hoge {
	 T value;

 public:
	 Hoge() : value(0) {}
	 Hoge(T val) : value(val){}

	 operator T() const noexcept{
		 return value;
	 }

	 // ++n
	 T& operator++() {
		 value = value + 1;
		 return(value);
	 }

	 // n++
	 T operator++(int) {
		 T oldValue = value;
		 value = value + 1;
		 return(oldValue);
	 }

	 // n + x
	 T operator+=(const T& arg){
		 value = value + arg;
		 return(value);
	 }
 };

 template<class T>
 Hoge<T> operator+(const Hoge<T>& lhs, const Hoge<T>& rhs) {
	 T val = (T)lhs + (T)rhs;
	 Hoge<T> ret = Hoge<T>(val);
	 return(ret);
 }


int main() {
	int n = 0;

	cout << n++				<< "    n=" << n << endl;
	cout << ++n				<< "    n=" << n << endl;

	cout << n + 1			<< "    n=" << n << endl;
	cout << (n += 1)		<< "    n=" << n << endl;
	cout << (n = n + 1)		<< "    n=" << n << endl;


	cout << endl;
	for (int i = 0; i < 10; i++) {
		cout << i << "    i=" << i << endl;
	}



	cout << endl;
	for (int i = 0; i++ < 10; ) {
		cout << i << "    i=" << i << endl;
	}
	cout << endl;
	for (int i = -1; i++ < 9; ) {
		cout << i << "    i=" << i << endl;
	}



	cout << endl;
	for (int i = 0; ++i < 10; ) {
		cout << i << "    i=" << i << endl;
	}
	cout << endl;
	for (int i = -1; ++i < 10; ) {
		cout << i << "    i=" << i << endl;
	}

	Hoge<int> h0;
	Hoge<int> h1(1);

	cout << endl;
	cout << h0++			<< "    h0=" << h0 << endl;
	cout << ++h0			<< "    h0=" << h0 << endl;
	cout << (h0+=2)			<< "    h0=" << h0 << endl;
	
	cout << (h0 + h1)		<< "    h0=" << h0 << endl;

	return 1;
}



















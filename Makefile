#make bash file executable
#compile c++ code
CXX = g++
CXXFLAGS= -Wformat -O3

TRate:
	chmod +x TRate.sh

	$(CXX) -o $@ $(CXXFLAGS) TR.v1.cpp
	
clean:

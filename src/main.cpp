#include <boost/lambda/lambda.hpp>
#include <boost/filesystem.hpp>
#include "HelloWorld.h"
#include <iostream>
#include <iterator>
#include <algorithm>

int main()
{
	// Get the current directory
	auto path = boost::filesystem::current_path();
	std::cout << path << "\n";

	// Print the content of the current directory
	for(auto &entry : boost::filesystem::directory_iterator(path))
	{
		std::cout << entry << std::endl;
	}

    typedef std::istream_iterator<int> in;

    std::cout << "Type in any number: ";

    std::for_each(
        in(std::cin), in(), std::cout 
                << (boost::lambda::_1 * 10) 
                << "\nType in another number: " );


    std::cout << "boost project";
	return 0;
}
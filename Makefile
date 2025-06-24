all:
	cobc -free -x -Wall -Icopybooks src/cics_dispatcher.cbl -o cics_dispatcher
	cobc -free -x -Wall -Icopybooks tests/cics_test.cbl -o cics_test
test:
	./cics_test
clean:
	rm -f cics_dispatcher cics_test *.exe *.o

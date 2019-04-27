# Default make target
.PHONY: testD1


DEMO1_TESTS = \
	inst_tests \
	complex_demo1 \
	rand_simple \
	rand_complex \
	rand_ctrl \
	rand_mem \

DEMO2_TESTS = \
	complex_demo2 \

DEMO3_TESTS = \
	perf \
	complex_demofinal \
	rand_final \
	rand_ldst \
	rand_idcache \
	rand_icache \
	rand_dcache \

EX_TESTS = \
	complex_demo3 \
	
SCRIPT = wsrun.pl

TEST_FLAGS = 

FOLDER_ROOT = ~sinclair/courses/cs552/spring2019/handouts/testprograms/public

# Tests for individual demos
testD1:	test1 

testD2: test1 test2

testD3: test1 test2 test3 testx

# Tests for individual test groups
test1: TESTS=$(DEMO1_TESTS)
test1: test_step cleanAll

test2: TESTS=$(DEMO2_TESTS) TEST_FLAGS=-pipe
test2: test_step cleanAll

test3: TESTS=$(DEMO3_TESTS) TEST_FLAGS=-pipe
test3: test_step cleanAll

testx: TESTS=$(EX_TESTS) 
testx: test_step cleanAll

# Cleaning scripts
clean:
	rm -rf *.asm
	rm -rf __work archsim.out archsim.ptrace *.trace dump.vcd dump.wlf dumpfile *.img *.dmem *.reg *.lst transcript verilog verilogsim.log

cleanAll: clean
	rm -rf summary.log

cleanLog:
	rm -rf ../summary/*.log

# Universal tester 
test_step:
	@for test in $(TESTS) ; do \
		cp $(FOLDER_ROOT)/$$test/*.asm . ; \
		$(SCRIPT) $(TEST_FLAGS) -list $(FOLDER_ROOT)/$$test/all.list proc_hier_bench *.v ; \
		mv summary.log ../summary/$$test.summary.log ; \
	done


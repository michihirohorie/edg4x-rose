include $(top_srcdir)/config/Makefile.for.ROSE.includes.and.libs

#===============================================================================
if ROSE_BUILD_X10_LANGUAGE_SUPPORT
#===============================================================================
ROSE_TRANSLATOR = $(top_builddir)/tests/testTranslator
$(ROSE_TRANSLATOR):
	@$(MAKE) testTranslator -C $(top_builddir)/tests

ROSE_FLAGS =

TESTCODES = \
    HelloWholeWorld.x10 \
    EmptyClass.x10 \
    EmptyClass2.x10 \
    Atomic0.x10 \
    ClockedAsync.x10 \
    ClockedFinish.x10 \
    ClockedAsync.x10 \
    Fibonacci.x10 \
    NestedClass1.x10 \
    NestedClass2.x10 \
    NestedClass3.x10 \
    NestedClass1_p.x10 \
    NestedClass2_p.x10 \
    NestedClass3_p.x10 \
    StaticNestedClass0.x10 \
    StaticNestedClass1.x10 \
    StaticNestedClass2.x10 \
    For0.x10 \
    For1.x10 \
    For2.x10 \
    For3.x10 \
    For4.x10 \
    For5.x10 \
    For6.x10 \
    For7.x10 \
    For8.x10 \
    For0_p.x10 \
    For1_p.x10 \
    For2_p.x10 \
    For3_p.x10 \
    For4_p.x10 \
    For5_p.x10 \
    For6_p.x10 \
    For7_p.x10 \
    For8_p.x10 \
    FunctionParameter_var.x10 \
    FunctionParameter_val.x10 \
    FunctionParameter_val2.x10 \
    Import0.x10 \
    Import1.x10 \
    Import0_p.x10 \
    Import1_p.x10 \ 
    If0.x10 \
    While0.x10 \
    While1.x10 \
    While2.x10 \
    While3.x10 \
    While4.x10 \
    Block0.x10 \
    Dowhile0.x10 \
    IntLiteral0.x10 \
    BooleanLiteral0.x10 \
    Instanceof0.x10 \
    Constructor0.x10 \
    Constructor1.x10 \
    Constructor2.x10 \
    Assert0.x10 \
    Assert1.x10 \
    Assert2.x10 \
    Assert3.x10 \
    LocalAssignment0.x10 \
    FieldDecl0.x10 \ 
    PropertyDecl0.x10 \
    PropertyDecl1.x10 \
    PropertyDecl2.x10 \
    ParseInt0.x10 \ 
    Field0.x10 \ 
    Field1.x10 \ 
    Field0_p.x10 \ 
    Field1_p.x10 


# Warning: Use -rose:output to unparse file in build tree, rather
# than override the original file in the source tree.
$(TESTCODES:.x10=.compile): $(ROSE_TRANSLATOR)
	$(ROSE_TRANSLATOR) \
			$(ROSE_FLAGS) \
			"$(srcdir)/$(@:.compile=.x10)" \
			-rose:output "$(@:.compile=.x10)"

check-local:
	@$(MAKE) $(TESTCODES:.x10=.compile)
	@echo "***********************************************************************************************"
	@echo "****** ROSE/tests/CompileTests/x10_tests: make check rule complete (terminated normally) ******"
	@echo "***********************************************************************************************"

clean-local:
	rm -f *.java
	rm -f *.class
	rm -f *.x10

#===============================================================================
else
#===============================================================================
check-local:
	@echo "Skipping x10_tests because X10 language support is not enabled, see ROSE/configure --help"
	@echo "***********************************************************************************************"
	@echo "****** ROSE/tests/CompileTests/x10_tests: make check rule complete (terminated normally) ******"
	@echo "***********************************************************************************************"
#===============================================================================
endif
#===============================================================================

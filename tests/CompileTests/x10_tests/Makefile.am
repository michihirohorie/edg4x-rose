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
    For9.x10 \
    For10.x10 \
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
    Field1_p.x10 \
    Exception0.x10 \
    Exception1.x10 \
    MethodDecl0.x10 \
    MethodDecl1.x10 \
    Rail0.x10 \
    Rail1.x10 \
    Rail2.x10 \
    Rail3.x10 \
    Rail4.x10 \
    Rail5.x10 \
    Rail6.x10 \
    Rail7.x10 \
    Rail8.x10 \
    Rail9.x10 \
    Rail10.x10 \
    Rail11.x10 \
    TypeParam0.x10 \
    TypeParam1.x10 \
    TypeParam2.x10 \
    TypeParam3.x10 \
    TypeParam0_p.x10 \
    TypeParam1_p.x10 \
    TypeParam2_p.x10 \
    Here0.x10 \
    Here1.x10 \
    MethodCall0.x10 \
    MethodCall1.x10 \
    Switch0.x10 \
    Switch1.x10 \
    Measure_CUDA.x10 \
    Constructor0.x10 \
    Constructor1.x10 \
    Constructor2.x10 \
    Constructor3.x10 \
    AssignOp0.x10 \
    ThisReference0.x10 \
    ThisReference1.x10 \
    EqualOp0.x10 \
    EqualOp1.x10 \ 
    EqualOp2.x10 \
    Minus0.x10 \
    Minus1.x10 \
    NotEqual0.x10 \
    NotEqual1.x10 \
    Struct0.x10 \
    Struct1.x10 \
    Struct2.x10 \
    Closure0.x10 \
    Closure1.x10 \
    Closure2.x10 \
    Closure3.x10 \
    Closure4.x10 \
    Closure5.x10 \
    Closure6.x10 \
    Annotation0.x10 \
    Annotation1.x10 \
    Annotation2.x10 \
    HelloWorld.x10 \
    ArraySum.x10 \
    Helper0.x10 \
    NQueensPar.x10 
#    KMeans.x10

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

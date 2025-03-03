.PHONY: all clean

CXX = g++
FLEX = flex
CXXFLAGS = -std=c++11

all: _build/scanner _build/cmos

_build/scanner: _build/lex.yy.c
	$(CXX) $(CXXFLAGS) -o $@ $< 

_build/lex.yy.c: cmos.l
	@mkdir -p _build
	$(FLEX) -o $@ $<

_build/cmos: cmos.cc
	@mkdir -p _build
	$(CXX) $(CXXFLAGS) -o $@ $<

clean:
	rm -rf _build scanner_out.txt tokens.txt PlagarismReport.txt

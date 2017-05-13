# Make stl and dxf files from scad files
# mark a module line with a stl or dxf in the comment
# to generate a stl or dxf file

FA:=2
FS:=2
SED := sed
scadsearch=$(patsubst src/%,build/%,$(shell $(SED) '/^module [A-Za-z0-9_]*()$(1)$$/!d;/$(4)/d;s/module /$(subst /,\/,$(2))-/;s/().*/$(3)/' $(2).scad))
scadpart=$(shell echo -n $(1) | $(SED) 's,-[^-]*$$,,')
modulepart=$(shell echo -n $(1) | $(SED) 's,^.*-,,')()
ofile=$(1:%*%=%)
ifile=$(1:%*%=%.scad)


SCADS = $(patsubst %.scad,%,$(wildcard src/*.scad))
STLS = $(foreach O,$(SCADS),$(call scadsearch,\(\(.*make.*\)\|\(.*supported.*\)\)\{2\},$O,\.stl,^$$))
STLGS = $(foreach O,$(SCADS),$(call scadsearch,\(\(.*make.*\)\|\(.*supported.*\)\)\{2\},$O,-s\.gco,unsupported))
STLGU = $(foreach O,$(SCADS),$(call scadsearch,\(\(.*make.*\)\|\(.*unsupported.*\)\)\{2\},$O,-u\.gco,^$$))
TESTS = $(foreach O,$(SCADS),$(call scadsearch,\(\(.*test.*\)\|\(.*supported.*\)\)\{2\},$O,\.stl,^$$))
TESTGS = $(foreach O,$(SCADS),$(call scadsearch,\(\(.*test.*\)\|\(.*supported.*\)\)\{2\},$O,-s\.gco,unsupported))
TESTGU = $(foreach O,$(SCADS),$(call scadsearch,\(\(.*test.*\)\|\(.*unsupported.*\)\)\{2\},$O,-u\.gco,^$$))
DXFS = $(foreach O,$(SCADS),$(call scadsearch,.*make.*,$O,\.dxf,supported))
DXFT = $(foreach O,$(SCADS),$(call scadsearch,.*test.*,$O,\.dxf,supported))

default: all;

debug:
	echo SCADS: $(SCADS)
	echo DXFS: $(DXFS)
	echo DXFT: $(DXFT)
	echo STLS: $(STLS)
	echo STLGS: $(STLGS)
	echo STLGU: $(STLGU)
	echo TESTS: $(TESTS)
	echo TESTGS: $(TESTGS)
	echo TESTGU: $(TESTGU)

all: $(STLS) $(DXFS);
test: $(TESTS) $(DXFT);

SLICER := /home/pi/installs/Slic3r/slic3r
SECONDARY:= $(patsubst %.stl,%.scad,$(STLS) $(TESTS)) $(patsubst %.dxf,$.scad,$(DXFS) $(DXFT))
.SECONDARY: $(SECONDARY)
.PHONY: print clean real-clean

include $(wildcard build/*.deps)

clean:
	$(RM) build/* *.stl *.gco *.dxf

build/:
	mkdir build

real-clean: clean
	$(RM) $(SECONDARY)

build/%.scad: USE=$(CURDIR)/src/$(call scadpart,$*)
build/%.scad: MODULE=$(call modulepart,$*)
build/%.scad: $(call scadpart,$*) build/
	echo  "use <$(USE).scad>;\n\n\$$fa=$(FA);\n\$$fs=$(FS);\n\n$(MODULE);" > $@

%.dxf: %.scad
	openscad -m make -o $@ -d $@.predeps $<
	cat $@.predeps | sed -e 's,/[^/]*/\.\./,/,g;s,/\(\./\)\+,/,g;s,$(CURDIR)/,,g'  > $@.deps
	$(RM) $@.predeps

%.stl:  %.scad
	openscad -m make -o $@ -d $@.predeps $<
	cat $@.predeps | sed -e 's,/[^/]*/\.\./,/,g;s,/\(\./\)\+,/,g;s,$(CURDIR)/,,g'  > $@.deps
	$(RM) $@.predeps

%-s.gco: %.stl
	$(SLICER) --load profiles.ini -o $@ $<

%-u.gco: %.stl
	$(SLICER) --load profile.ini -o $@ $<

printtest: $(TESTGS) $(TESTGU)
	cp -t /home/pi/.octoprint/uploads/ $?

print: $(STLGS) $(STLGU) 
	cp -t /home/pi/.octoprint/uploads/ $?

LATEXMK=./latexmk/latexmk

# Various dependencies
MAIN=thesis
MAIN_PDF=$(MAIN).pdf
MAIN_TEX=$(MAIN).tex
HELPER_FILES= makefile format/mnthesis.cls
#PRELIMS:=$(wildcard preliminaries/*.tex)
CHAPTERS:=$(wildcard sections/*.tex)
FIGURES := $(wildcard figures/*)

AUX := $(wildcard sections/default/*.aux) $(wildcard sections/main/*.aux) $(wildcard sections/appendix/*.aux)

# Tell make what our reserved target names are
#
# By using ALWAYS_COMPILE as an undefined target, it will always force the main
# PDF to compile. latexmk is smart and will do the minimum needed each time.
.PHONY: ALWAYS_COMPILE clean all tidy

# The default target
all: $(MAIN_PDF)

# Instructions to make the main pdf
#$(MAIN_PDF): ALWAYS_COMPILE $(MAIN_TEX) $(HELPER_FILES) $(PRELIMS) $(CHAPTERS) $(FIGURES)
$(MAIN_PDF): ALWAYS_COMPILE $(MAIN_TEX) $(HELPER_FILES) $(CHAPTERS) $(FIGURES)
	$(LATEXMK) -pdf $(MAIN_TEX)

# Clean up all the regeneratable files except for the final document (the .pdf)
tidy:
	$(LATEXMK) -c $(MAIN_TEX) $(CHAPTERS); rm `find . -type f \( -iname "*.aux" \)`

# Clean up all the regeneratable files, including the final document
clean:
	$(LATEXMK) -C $(MAIN_TEX)

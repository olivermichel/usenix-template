DEPS = $(wildcard sec/*.tex) $(wildcard sec/**/*.tex) $(wildcard fig/*) $(wildcard fig/**/*) $(wildcard *.bib)
LATEXMK = latexmk -use-make -pdf -bibtex -pdflatex="pdflatex -interactive=nonstopmode"
DETEX = detex

all: pdf txt

pdf: $(addsuffix .pdf, $(basename $(wildcard *.tex)))

txt: $(addsuffix .txt, $(basename $(wildcard *.tex)))

usenix2019_v3.sty:
	curl https://www.usenix.org/sites/default/files/$@ -o $@


%.pdf: %.tex $(DEPS) usenix2019_v3.sty
	$(LATEXMK) $<

%.txt: %.tex $(DEPS)
	$(DETEX) $< | uniq > $@

clean:
	latexmk -c
	$(RM) *.toc *.log *.aux *.fls *.bbl *.blg *.fdb_latexmk

spotless: clean
	latexmk -C
	$(RM) *.txt

.PHONY: all clean spotless
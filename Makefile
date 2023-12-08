days=$(wildcard dec*)

.PHONY: all
all: $(days)


.PHONY: $(days)
$(days): dec%: dec%/input.txt
	$(info Computing solutions for $@)
	$(MAKE) -C $@

dec%/input.txt:
	echo $@ | grep -oP '\d\d' | xargs ./get_input.sh > /dev/null

.NOTPARALLEL:
.SILENT:

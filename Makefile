all: dec*


.PHONY: dec*
dec*:
	$(info Computing solutions for $@)
	$(MAKE) -C $@

.NOTPARALLEL:
.SILENT:

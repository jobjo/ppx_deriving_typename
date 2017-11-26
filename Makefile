PPX_TYPENAME = _build/default/.ppx/ppx_deriving_typename+ppx_driver.runner/ppx.exe

.PHONY: build clean install uninstall reinstall test
build:
	jbuilder build @install --dev

clean:
	jbuilder clean

install:
	jbuilder install

uninstall:
	jbuilder uninstall

reinstall: uninstall install

test:
	jbuilder runtest --dev

test-source:
	$(PPX_TYPENAME) test/run.ml


all: build install test


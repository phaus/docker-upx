VERSION=3.96

build:
	docker build --build-arg UPX_VERSION=$(VERSION) -t phaus/upx:$(VERSION) .
	docker tag phaus/upx:$(VERSION) phaus/upx:latest

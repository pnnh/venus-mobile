DIR := $(CURDIR)

web :
	flutter build web --release --web-renderer auto --dart-define=FLUTTER_WEB_CANVASKIT_URL=canvaskit/

compress :
	brotli-cli compress build/web/canvaskit/profiling/canvaskit.wasm
	brotli-cli compress build/web/canvaskit/canvaskit.wasm
	brotli-cli compress build/web/assets/fonts/WenQuanYi/wqy-microhei-lite.ttc

clean :
	-rm -f ./dist

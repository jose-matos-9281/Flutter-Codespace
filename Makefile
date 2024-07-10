run:
	flutter run -d web-server --web-hostname 0.0.0.0 --web-port 3000

build:
	web:
		flutter build web --web-renderer canvaskit
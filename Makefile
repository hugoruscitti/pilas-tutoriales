VERSION=0.0.8
NOMBRE="pilas-tutoriales"

N=[0m
G=[01;32m
Y=[01;33m
B=[01;34m

comandos:
	@echo ""
	@echo "${B}Comandos disponibles para ${G}pilas-tutoriales${N}"
	@echo ""
	@echo "  ${Y}Para desarrolladores${N}"
	@echo ""
	@echo "    ${G}iniciar${N}  	   Instala las dependencias."
	@echo "    ${G}ejecutar_linux${N}  Prueba la aplicacion sobre Huayra."
	@echo "    ${G}ejecutar_mac${N}    Prueba la aplicacion sobre OSX."
	@echo ""
	@echo "  ${Y}Para distribuir${N}"
	@echo ""
	@echo "    ${G}version${N}         Genera una nueva versión."
	@echo "    ${G}subir_version${N}   Sube version generada al servidor."
	@echo "    ${G}publicar${N}        Publica el cambio para el paquete deb."
	@echo "    ${G}binarios${N}        Genera las versiones binarias de la aplicación."
	@echo ""

iniciar:
	npm install

ejecutar_linux:
	nw src

ejecutar_mac:
	/Applications/nwjs.app/Contents/MacOS/nwjs src

test_mac: ejecutar_mac

publicar:
	dch -i

version:
	@bumpversion patch --current-version ${VERSION} src/package.json src/partials/tutoriales.html Makefile --list
	@echo "Es recomendable escribir el comando que genera los tags y sube todo a github:"
	@echo ""
	@echo "make ver_sync"

subir_version:
	git commit -am 'release ${VERSION}'
	git tag '${VERSION}'
	git push
	git push --all
	git push --tags

binarios:
	@node_modules/.bin/electron-packager dist pilas-tutoriales --app-version=0.1 --platform=win32 --arch=ia32 --electron-version=0.37.6 --ignore=node_modules --out=binarios
	@zip -qr binarios/${NOMBRE}-${VERSION}-win32.zip binarios/pilas-tutoriales-win32-ia32/

.PHONY: binarios


# SPDX-FileCopyrightText: 2024 UnionTech Software Technology Co., Ltd.
#
# SPDX-License-Identifier: CC0-1.0

PO_FILES=$(shell find ./i18n/ -type f -name '*.po')
MO_FILES=$(patsubst ./i18n/%.po,./i18n/%.mo,$(PO_FILES))

all: build

build: $(MO_FILES)

install:
	install -Dm 644 ./assets/dummyapp-wpsoffice.svg ${DESTDIR}/usr/share/icons/hicolor/scalable/apps/dummyapp-wpsoffice.svg

	install -Dm 644 ./misc/dummyapp-wpsoffice.desktop ${DESTDIR}/usr/share/applications/dummyapp-wpsoffice.desktop
	install -Dm 644 ./misc/dummyapp-wpsoffice.metainfo.xml ${DESTDIR}/usr/share/metainfo/dummyapp-wpsoffice.metainfo.xml

	install -Dm 755 ./src/dummyapp-wpsoffice.sh ${DESTDIR}/usr/bin/dummyapp-wpsoffice.sh

#	Install all .mo files.
#	Path conversion required. "./i18n/<app>/<lang>.mo" -> "/usr/share/locale/<lang>/LC_MESSAGES/<app>.mo"
	for LANGFILE in ./i18n/*/*.mo; do \
		DESTFILE=$$(echo $$LANGFILE | sed -E 's/.\/i18n\/(.+)\/(.+)\.mo/\2\/LC_MESSAGES\/\1.mo/g'); \
		install -Dm 644 $$LANGFILE ${DESTDIR}/usr/share/locale/$$DESTFILE; \
	done

clean:
	rm -f i18n/**/*.mo

# For translation
# --no-translator stops msginit from asking for an email address
generate_po:
	xgettext -o i18n/dummyapp-wpsoffice.pot src/dummyapp-wpsoffice.sh
	msginit --no-translator -i ./i18n/dummyapp-wpsoffice.pot -l zh_CN.UTF-8 -o i18n/dummyapp-wpsoffice/zh_CN.po

# PO -> MO generation
./i18n/%.mo: ./i18n/%.po
	msgfmt $< -o $@

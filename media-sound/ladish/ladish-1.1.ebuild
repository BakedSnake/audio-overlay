# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
PYTHON_REQ_USE='threads(+)'

inherit flag-o-matic python-single-r1 waf-utils

DESCRIPTION="LADI Session Handler - a session management system for JACK applications"
HOMEPAGE="https://ladish.org"
SRC_URI="https://github.com/LADI/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="debug doc lash gtk"
RESTRICT="mirror"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="media-libs/alsa-lib
	media-sound/jack2[dbus]
	sys-apps/dbus
	dev-libs/expat
	lash? ( !media-sound/lash )
	gtk? (
		x11-libs/gtk+:2
		gui-libs/libgnomecanvasmm
		dev-libs/cdbus
	)
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}
	doc? ( app-text/doxygen )
	dev-util/intltool
	virtual/pkgconfig"

DOCS=( AUTHORS NEWS )
QA_SONAME=( ".*/libalsapid.so" )

src_prepare() {
	sed -i -e "s/RELEASE = False/RELEASE = True/" wscript
	append-cxxflags '-std=c++11'

	default
}

src_configure() {
	local -a mywafconfargs=(
		--distnodeps
		$(usex debug --debug '')
		$(usex doc --doxygen '')
		$(usex lash '--enable-liblash' '')
		$(usex gtk '--enable-gladish' '')
	)

	waf-utils_src_configure "${mywafconfargs[@]}"
}

src_install() {
	if use doc ; then
		dodoc -r build/default/html/
	fi

	waf-utils_src_install
	python_fix_shebang "${ED}"
}

# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )
PYTHON_REQ_USE="threads(+)"
inherit python-any-r1 waf-utils

DESCRIPTION="libdbus helper library"
HOMEPAGE="https://github.com/LADI/cdbus"
SRC_URI="https://github.com/LADI/cdbus/archive/refs/tags/${PV}.tar.gz -> ${PN}.${PV}.tar.gz"
LICENSE="GPL-2 || ( GPL-2 AFL-2.1 )"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-apps/dbus"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig
	${PYTHON_DEPS}"

src_install() {
	waf-utils_src_install

	find "${ED}" \( -iname "gpl*.txt*" -o -iname "afl*.txt*" \) -delete || die
}

# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="C++ wrappers for libgnomecanvas (LADI project)"
HOMEPAGE="https://ladish.org"
EGIT_REPO_URI="https://github.com/LADI/libgnomecanvasmm.git"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""

RDEPEND="x11-libs/cairo[X]
	dev-cpp/cairomm[X]
	dev-cpp/gtkmm:2.4
	gnome-base/libgnomecanvas"
DEPEND="${RDEPEND}"

src_prepare() {
	./bootstrap
	eapply_user
}

src_configure() {
	econf --prefix=/usr
}

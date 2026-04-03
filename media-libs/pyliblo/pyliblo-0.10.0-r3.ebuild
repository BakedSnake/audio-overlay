# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="A Python wrapper for the liblo OSC library"
HOMEPAGE="http://das.nasophon.de/pyliblo"
SRC_URI="https://github.com/BakedSnake/pyliblo/releases/download/${PVR}/${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND=">=media-libs/liblo-0.32
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}
	>=dev-python/cython-3.2.4[${PYTHON_USEDEP}]"
BDEPEND=">=dev-lang/python-3.11.15[test] >=media-libs/liblo-0.32"

distutils_enable_tests unittest

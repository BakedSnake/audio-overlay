# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )
inherit meson python-any-r1 git-r3

DESCRIPTION="Minimal portable API for embeddable GUIs"
HOMEPAGE="https://github.com/lv2/pugl"
EGIT_REPO_URI="https://github.com/lv2/pugl.git"
LICENSE="ISC"
# subslot is SONAME version
SLOT="0/0.5.3"

IUSE="cairo doc opengl vulkan"
RDEPEND="x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXext
	x11-libs/libXrandr
	cairo? ( x11-libs/cairo )
	opengl? ( virtual/opengl )
	vulkan? ( media-libs/vulkan-loader )"
DEPEND="${RDEPEND}"
# shellcheck disable=SC2016
BDEPEND="
	$(python_gen_any_dep '
		dev-python/sphinx-lv2-theme[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
		dev-python/sphinxygen[${PYTHON_USEDEP}]
	')
	doc? ( app-text/doxygen )"

# Tests don't work in the sandbox
RESTRICT="test"

python_check_deps() {
	! use doc || \
		python_has_version "dev-python/sphinx-lv2-theme[${PYTHON_USEDEP}]" \
		&& python_has_version "dev-python/sphinx[${PYTHON_USEDEP}]" \
		&& python_has_version "dev-python/sphinxygen[${PYTHON_USEDEP}]"
}

src_configure() {
	local emesonargs=(
		"$(meson_feature cairo)"
		"$(meson_feature doc docs)"
		"$(meson_feature opengl)"
		"$(meson_feature vulkan)"

		-Dxcursor=enabled
		-Dxsync=enabled
		-Dxrandr=enabled

		-Dexamples=disabled
		-Dlint=false
		-Dtests=disabled
	)

	meson_src_configure
}

# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg cmake git-r3

DESCRIPTION="FM synthesizer plugin based on OPL3 sound chip emulation"
HOMEPAGE="https://github.com/jpcima/ADLplug"
EGIT_REPO_URI="https://github.com/jpcima/adlplug.git"
LICENSE="Boost-1.0 GPL-3 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS=""

IUSE="lv2 nsm standalone vst"
RESTRICT="mirror"
REQUIRED_USE="
	|| ( lv2 standalone vst )
	nsm? ( standalone )"

DEPEND="media-libs/alsa-lib
	media-libs/freetype
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXext
	x11-libs/libXinerama
	x11-libs/libXrandr
	standalone? ( virtual/jack )
	nsm? (
		media-libs/liblo
		media-sound/new-session-manager
	)"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DADLplug_CHIP=OPL3
		-DADLplug_LV2="$(usex lv2)"
		-DADLplug_VST2="$(usex vst)"
		-DADLplug_Standalone="$(usex standalone)"
		-DADLplug_Jack="$(usex standalone)"
	)

	cmake_src_configure
}

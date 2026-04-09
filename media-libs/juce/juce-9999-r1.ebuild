# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
CMAKE_MAKEFILE_GENERATOR=emake
EGIT_CLONE_TYPE=single+tags
inherit git-r3

DESCRIPTION="Open-source cross-platform C++ framework for desktop and mobile applications"
HOMEPAGE="https://juce.com/"
PNC=JUCE
EGIT_REPO_URI="https://github.com/${PN}-framework/${PNC}.git"
EGIT_SUBMODULES=()
if [[ "${PV}" != *9999 ]]; then
	EGIT_COMMIT="${PV}"
	KEYWORDS="~amd64"
fi
LICENSE="AGPLv3"
SLOT="0"

IUSE="alsa jack ladspa curl web standalone extras sources"
REQUIRED_USE="|| ( sources standalone )"

RDEPEND=">=x11-libs/libXinerama-1.1.6
	>=x11-libs/libX11-1.8.13
	>=x11-libs/libXcursor-1.2.3
	>=x11-libs/libXrandr-1.5.5
	>=x11-libs/libXrender-0.9.12
	>=x11-libs/libXext-1.3.7
	>=media-libs/mesa-26.0.3
	>=media-libs/fontconfig-2.17.1
	>=media-libs/freetype-2.14.3[X,harfbuzz]
	curl? ( net-misc/curl )
	alsa? ( >=media-libs/alsa-lib-1.2.15.3 )
	jack? ( >=media-sound/jack2-1.9.22 )
	ladspa? ( >=media-libs/ladspa-sdk-1.17-r2 )
	web? ( net-libs/webkit-gtk )"
DEPEND=${RDEPEND}

pkg_setup() {
	if use standalone; then
		inherit cmake
	fi
}

src_prepare() {
	if use standalone; then
		sed -i 's|bin/JUCE-${JUCE_VERSION}|bin|g' CMakeLists.txt
		cmake_src_prepare
	else
		eapply_user
	fi
}

src_configure() {
	if use standalone; then
		local mycmakeargs=(
			-DJUCE_JACK=$(usex jack ON OFF)
			-DJUCE_PLUGINHOST_LADSPA=$(usex ladspa ON OFF)
			-DJUCE_USE_CURL=$(usex curl ON OFF)
			-DJUCE_WEB_BROWSER=$(usex web ON OFF)
			-DJUCE_BUILD_EXTRAS=$(usex ON OFF)
			-DJUCE_TOOL_INSTALL_DIR=/usr/bin
		)

		cmake_src_configure
	fi
}

src_install() {
	if use sources; then
		insinto /usr/src/"${PN}"
		insopts -m 0755
		doins -r *
	fi
}

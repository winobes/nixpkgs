{ stdenv, fetchurl, pkgconfig, gtk3, gnome3, gdk-pixbuf, librsvg, wrapGAppsHook
, itstool, gsound, libxml2
, meson, ninja, python3, vala, desktop-file-utils
}:

stdenv.mkDerivation rec {
  pname = "iagno";
  version = "3.36.3";

  src = fetchurl {
    url = "mirror://gnome/sources/iagno/${stdenv.lib.versions.majorMinor version}/${pname}-${version}.tar.xz";
    sha256 = "0cid9fag8irlq0cywyqaj402vb60l8f66ld1zj7a023rg0khqnbb";
  };

  nativeBuildInputs = [
    meson ninja python3 vala desktop-file-utils
    pkgconfig wrapGAppsHook itstool libxml2
  ];
  buildInputs = [ gtk3 gnome3.adwaita-icon-theme gdk-pixbuf librsvg gsound ];

  enableParallelBuilding = true;

  passthru = {
    updateScript = gnome3.updateScript {
      packageName = "iagno";
      attrPath = "gnome3.iagno";
    };
  };

  meta = with stdenv.lib; {
    homepage = "https://wiki.gnome.org/Apps/Iagno";
    description = "Computer version of the game Reversi, more popularly called Othello";
    maintainers = teams.gnome.members;
    license = licenses.gpl2;
    platforms = platforms.linux;
  };
}

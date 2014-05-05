#! /bin/sh

export CFLAGS="-Os -m32 -march=pentium2 -mtune=nocona"
export PREFIX="$(pwd)/dnscrypt-proxy-win32"
export LDNS_PREFIX='/usr/mingw32'
export SODIUM_PREFIX='/tmp/libsodium-win32'

export CPPFLAGS="-I${SODIUM_PREFIX}/include"
export LDFLAGS="-L${SODIUM_PREFIX}/lib"

./configure --prefix="$PREFIX" --exec-prefix="$PREFIX" \
  --host=i686-w64-mingw32 \
  --sbindir="${PREFIX}/bin" \
  --enable-plugins \
  --with-included-ltdl && \
make install-strip

rm -fr "${PREFIX}/share"
rm -fr "${PREFIX}/lib/pkgconfig"
mv "${PREFIX}/lib/dnscrypt-proxy" "${PREFIX}/plugins"
rm -fr "${PREFIX}/lib"
cp "${LDNS_PREFIX}/bin/libldns-1.dll" "${PREFIX}/bin"
cp "${SODIUM_PREFIX}/bin/libsodium-4.dll" "${PREFIX}/bin"

if false; then
  upx --best --ultra-brute "${PREFIX}/dnscrypt-proxy.exe" &
  upx --best --ultra-brute "${PREFIX}/hostip.exe"
  wait
fi

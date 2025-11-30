PORTNAME=	janet-lsp
PORTVERSION=	0.0.11
CATEGORIES=	devel
                                                       
MAINTAINER=	dave@freedave.net
COMMENT=	janet LSP client
WWW=		https://github.com/CFiggers/janet-lsp/

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE

BUILD_DEPENDS=	jpm>=1.1.0:lang/jpm

USE_GITHUB=	yes
GH_ACCOUNT=	CFiggers
GH_PROJECT=	${PORTNAME}
GH_TAGNAME=	v${DISTVERSION}

# These are a little more recent that latest releases but that's how I initially built.
# Also there is no lockfile for the project yet.
GH_TUPLE=	CFiggers:jayson:4f54041617340c8ff99bc1e6b285b720184965e2:jayson/.deps/jayson \
		janet-lang:spork:7b780ccd6e0776dcbfc0427b553609f50bd92a9a:spork/.deps/spork \
		ianthehenry:judge:3b921850006200a31b015558a72b8a62672eac8e:judge/.deps/judge \
		CFiggers:cmd:b0a34d6e854578bd672d43303e80b9777af08b42:cmd/.deps/cmd

PLIST_FILES=	bin/janet-lsp

# A little more manual than just `jpm -l load-lockfile`, but this get everything in place
# using the ports machinery which is nice for checksums but also in case something has to
# be patched in the future. But it means we have to install in a workable order.
do-build:
	cd ${WRKSRC}/.deps/jayson && jpm --tree=${WRKSRC}/jpm_tree install
	cd ${WRKSRC}/.deps/spork && jpm --tree=${WRKSRC}/jpm_tree install
	cd ${WRKSRC}/.deps/cmd && jpm --tree=${WRKSRC}/jpm_tree install
	cd ${WRKSRC}/.deps/judge && jpm --tree=${WRKSRC}/jpm_tree install
	cd ${WRKSRC} && jpm --tree=${WRKSRC}/jpm_tree build

do-install:
	${MKDIR} ${STAGEDIR}/bin
	${INSTALL_PROGRAM} ${WRKSRC}/build/janet-lsp ${STAGEDIR}${PREFIX}/bin/${PORTNAME}

do-test:
	cd ${WRKSRC} && jpm test -l

.include <bsd.port.mk>

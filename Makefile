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

# These are a little more recent that latest releases. But there is no lockfile so
# by default jpm(1) would use HEAD. There is also a conflict for cmd and CFiggers is
# more recent. Add them to .deps/<order-to-be-built>
GH_TUPLE=	CFiggers:jayson:4f54041617340c8ff99bc1e6b285b720184965e2:jayson/.deps/1 \
		janet-lang:spork:7b780ccd6e0776dcbfc0427b553609f50bd92a9a:spork/.deps/2 \
		CFiggers:cmd:b0a34d6e854578bd672d43303e80b9777af08b42:cmd/.deps/3 \
		ianthehenry:judge:3b921850006200a31b015558a72b8a62672eac8e:judge/.deps/4

PLIST_FILES=	bin/janet-lsp

# Install in whatever order was given in the GH_TUPLE
do-build:
	cd ${WRKSRC}/.deps && for d in `ls | sort -n`; do \
		cd ${WRKSRC}/.deps/$$d && jpm --tree=${WRKSRC}/jpm_tree install; \
	done
	cd ${WRKSRC} && jpm --tree=${WRKSRC}/jpm_tree build

do-install:
	${MKDIR} ${STAGEDIR}/bin
	${INSTALL_PROGRAM} ${WRKSRC}/build/janet-lsp ${STAGEDIR}${PREFIX}/bin/${PORTNAME}

do-test:
	cd ${WRKSRC} && jpm test -l

.include <bsd.port.mk>

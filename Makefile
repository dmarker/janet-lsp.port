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

PLIST_FILES=	bin/janet-lsp

do-build:
	cd ${WRKSRC} && jpm deps -l && jpm build -l

do-install:
	${MKDIR} ${STAGEDIR}/bin
	${INSTALL_PROGRAM} ${WRKSRC}/build/janet-lsp ${STAGEDIR}${PREFIX}/bin/${PORTNAME}

do-test:
	cd ${WRKSRC} && jpm test -l

.include <bsd.port.mk>

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
# more recent.
GH_TUPLE=	CFiggers:cmd:${_CMD_SHA_}:cmd \
		CFiggers:jayson:${_JAYSON_SHA_}:jayson \
		ianthehenry:judge:${_JUDGE_SHA_}:judge \
		janet-lang:spork:${_SPORK_SHA_}:spork

PLIST_FILES=	bin/janet-lsp

# The only dependency before building janet-lsp is that `judge` depends on `cmd`.
do-build:
	cd ${WRKDIR}/cmd-${_CMD_SHA_} && jpm --tree=${WRKSRC}/jpm_tree install
	cd ${WRKDIR}/jayson-${_JAYSON_SHA_} && jpm --tree=${WRKSRC}/jpm_tree install
	cd ${WRKDIR}/judge-${_JUDGE_SHA_} && jpm --tree=${WRKSRC}/jpm_tree install
	cd ${WRKDIR}/spork-${_SPORK_SHA_} && jpm --tree=${WRKSRC}/jpm_tree install
	cd ${WRKSRC} && jpm --tree=${WRKSRC}/jpm_tree build

do-install:
	${MKDIR} ${STAGEDIR}/bin
	${INSTALL_PROGRAM} ${WRKSRC}/build/janet-lsp ${STAGEDIR}${PREFIX}/bin/${PORTNAME}

do-test:
	cd ${WRKSRC} && jpm test -l

# Make it easy to find dependencies so we don't have to do extra copy
_CMD_SHA_ = b0a34d6
_JAYSON_SHA_ = 4f54041
_JUDGE_SHA_ = 3b92185
_SPORK_SHA_ = 7b780cc

.include <bsd.port.mk>

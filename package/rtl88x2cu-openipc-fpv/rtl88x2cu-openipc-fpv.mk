################################################################################
#
# rtl88x2cu-openipc-fpv
#
################################################################################

ifeq ($(LOCAL_DOWNLOAD),y)
RTL88X2CU_OPENIPC_FPV_SITE_METHOD = git
RTL88X2CU_OPENIPC_FPV_SITE = https://github.com/libc0607/rtl88x2cu-20230728
RTL88X2CU_OPENIPC_FPV_VERSION = $(shell git ls-remote $(RTL88X2CU_OPENIPC_FPV_SITE) HEAD | head -1 | cut -f1)
else
RTL88X2CU_OPENIPC_FPV_SITE = https://github.com/libc0607/rtl88x2cu-20230728/archive
# Pin to a real commit: the repo's only branch is `main` (default renamed from
# `master`), so the old `master.tar.gz` now 404s and buildroot silently reused a
# STALE cached master.tar.gz -- a different snapshot that broke the A-MSDU patch.
# Pinning to the SHA busts that cache and guarantees the source matches the patches.
RTL88X2CU_OPENIPC_FPV_SOURCE = 132c1e32b93c0678c01e631bfb9d014a575eeb13.tar.gz
RTL88X2CU_OPENIPC_FPV_VERSION = 132c1e32b93c0678c01e631bfb9d014a575eeb13
endif

RTL88X2CU_OPENIPC_FPV_LICENSE = GPL-2.0
RTL88X2CU_OPENIPC_FPV_LICENSE_FILES = COPYING

RTL88X2CU_OPENIPC_FPV_MODULE_MAKE_OPTS = CONFIG_RTL8822CU=m \
	KVER=$(LINUX_VERSION_PROBED) \
	KSRC=$(LINUX_DIR)

$(eval $(kernel-module))
$(eval $(generic-package))

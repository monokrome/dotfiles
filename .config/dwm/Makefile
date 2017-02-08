url_to_words = $(lastword $(subst /, ,$1))

source_url = http://dl.suckless.org/dwm/dwm-6.0.tar.gz
source_filename = $(call notdir,$(call url_to_words,$(source_url)))

patch_filename = $(patches_dirname)/$1
patches_dirname = $(CURDIR)/patches

build_dirname = $(CURDIR)/$(call basename,$(call basename,${source_filename}))

dwm_filename = $(build_dirname)/dwm

url_to_patch_filename = $(call patch_filename,$(call url_to_words,$1))

patches = http://dwm.suckless.org/patches/dwm-6.0-systray.diff # \
          # http://dwm.suckless.org/patches/dwm-6.0-single_window_no_border.diff \
          # http://dwm.suckless.org/patches/dwm-6.0-pertag.diff \
          # http://dwm.suckless.org/patches/dwm-r1522-viewontag.diff

patch_filenames = $(foreach patch,$(patches),$(call url_to_patch_filename,$(patch)))

postbuild_patches = https://raw.github.com/monokrome/dwm-custom-patches/master/dwm-6.0-justtile.diff \
                    # https://raw.github.com/monokrome/dwm-custom-patches/master/dwm-6.0-urxvt.diff \
                    # https://raw.github.com/monokrome/dwm-custom-patches/master/dwm-6.0-standardkill.diff \
                    # https://raw.github.com/monokrome/dwm-custom-patches/master/dwm-6.0-custom-nostatus.diff \
                    # https://raw.github.com/monokrome/dwm-custom-patches/master/dwm-6.0-namedtags.diff \
                    # https://raw.github.com/monokrome/dwm-custom-patches/master/dwm-6.0-noapps.diff \
                    # https://raw.github.com/monokrome/dwm-custom-patches/master/dwm-6.0-custom-hidebar.diff \
                    # http://dwm.suckless.org/patches/dwm-6.0-attachabove.diff \
                    # http://dwm.suckless.org/patches/dwm-6.0-bstack.diff

postbuild_patch_filenames = $(foreach patch,$(postbuild_patches),$(call url_to_patch_filename,$(patch)))

# TODO: Patches to modify for DWM 6.0
#	combo
#	fibonacci
#	gestures
#	keymodes
#	nametag

# TODO: The following collide with other ones (most notably systray)
#          http://dwm.suckless.org/patches/autoresize.diff
#          http://dwm.suckless.org/patches/dwm-6.0-statusallmons.diff
#          http://dwm.suckless.org/patches/dwm-6.0-zoomswap.diff

# TODO: Paths are completely borked in this one.
#          http://dwm.suckless.org/patches/dwm-6.0-xft.diff

# This also rebuilds dwm again after applying patches. First build was
# required in order to create config.h for patching the configuration.
all: $(postbuild_patch_filenames)
	make -C $(build_dirname)

$(postbuild_patch_filenames): $(dwm_filename)
	cd $(postbuild_patches_dirname) && wget -q $(filter %/$(@F),$(postbuild_patches)) -O $@
	cd $(build_dirname) && patch -p1 < $@

$(dwm_filename): $(build_dirname) $(patch_filenames)
	make -C $(build_dirname)

$(patch_filenames): $(patches_dirname)
	cd $(patches_dirname) && wget -q $(filter %/$(@F),$(patches)) -O $@
	cd $(build_dirname) && patch -p1 < $@

$(patches_dirname):
	mkdir -p $@

$(build_dirname): $(source_filename)
	tar -xvf $(source_filename)

$(source_filename):
	wget $(source_url) -O $@

install:
	ln -s $(build_dirname)/dwm ~/bin/dwm

clean:
	@rm $(source_filename)
	@rm -rf $(patches_dirname)
	@rm -rf $(build_dirname)

.PHONY: all clean patch

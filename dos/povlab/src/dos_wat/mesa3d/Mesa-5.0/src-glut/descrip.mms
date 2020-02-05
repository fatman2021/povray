# Makefile for GLUT for VMS
# contributed by Jouk Jansen  joukj@crys.chem.uva.nl

.first
	define gl [-.include.gl]

.include [-]mms-config.

##### MACROS #####
GLUT_MAJOR = 3
GLUT_MINOR = 7

VPATH = RCS

INCDIR = [-.include]
LIBDIR = [-.lib]
CFLAGS = /nowarn/include=$(INCDIR)/prefix=all/name=(as_is,short)

SOURCES = \
glut_8x13.c \
glut_9x15.c \
glut_bitmap.c \
glut_bwidth.c \
glut_cindex.c \
glut_cmap.c \
glut_cursor.c \
glut_dials.c \
glut_dstr.c \
glut_event.c \
glut_ext.c \
glut_fullscrn.c \
glut_gamemode.c \
glut_get.c \
glut_glxext.c \
glut_hel10.c \
glut_hel12.c \
glut_hel18.c \
glut_init.c \
glut_input.c \
glut_joy.c \
glut_key.c \
glut_keyctrl.c \
glut_keyup.c \
glut_menu.c \
glut_menu2.c \
glut_mesa.c \
glut_modifier.c \
glut_mroman.c \
glut_overlay.c \
glut_roman.c \
glut_shapes.c \
glut_space.c \
glut_stroke.c \
glut_swap.c \
glut_swidth.c \
glut_tablet.c \
glut_teapot.c \
glut_tr10.c \
glut_tr24.c \
glut_util.c \
glut_vidresize.c \
glut_warp.c \
glut_win.c \
glut_winmisc.c \
layerutil.c

OBJECTS = \
glut_8x13.obj,\
glut_9x15.obj,\
glut_bitmap.obj,\
glut_bwidth.obj,\
glut_cindex.obj,\
glut_cmap.obj,\
glut_cursor.obj,\
glut_dials.obj,\
glut_dstr.obj,\
glut_event.obj,\
glut_ext.obj,\
glut_fullscrn.obj,\
glut_gamemode.obj

OBJECTS1=glut_get.obj,\
glut_glxext.obj,\
glut_hel10.obj,\
glut_hel12.obj,\
glut_hel18.obj,\
glut_init.obj,\
glut_input.obj,\
glut_joy.obj,\
glut_key.obj,\
glut_keyctrl.obj,\
glut_keyup.obj,\
glut_menu.obj,\
glut_menu2.obj,\
glut_mesa.obj,\
glut_modifier.obj

OBJECTS2=glut_mroman.obj,\
glut_overlay.obj,\
glut_roman.obj,\
glut_shapes.obj,\
glut_space.obj,\
glut_stroke.obj,\
glut_swap.obj,\
glut_swidth.obj,\
glut_tablet.obj,\
glut_teapot.obj,\
glut_tr10.obj,\
glut_tr24.obj,\
glut_util.obj,\
glut_vidresize.obj

OBJECTS3=glut_warp.obj,\
glut_win.obj,\
glut_winmisc.obj,\
layerutil.obj

##### RULES #####

VERSION=Glut V3.7

##### TARGETS #####

# Make the library:
$(LIBDIR)$(GLUT_LIB) : $(OBJECTS) $(OBJECTS1) $(OBJECTS2) $(OBJECTS3)
.ifdef SHARE
  @ WRITE_ SYS$OUTPUT "  generating mesagl1.opt"
  @ OPEN_/WRITE FILE  mesagl1.opt
  @ WRITE_ FILE "!"
  @ WRITE_ FILE "! mesagl1.opt generated by DESCRIP.$(MMS_EXT)" 
  @ WRITE_ FILE "!"
  @ WRITE_ FILE "IDENTIFICATION=""$(VERSION)"""
  @ WRITE_ FILE "GSMATCH=LEQUAL,3,7
  @ WRITE_ FILE "$(OBJECTS)"
  @ WRITE_ FILE "$(OBJECTS1)"
  @ WRITE_ FILE "$(OBJECTS2)"
  @ WRITE_ FILE "$(OBJECTS3)"
  @ WRITE_ FILE "[-.lib]libmesaglu.exe/SHARE"
  @ WRITE_ FILE "[-.lib]libmesagl.exe/SHARE"
  @ write file "sys$library:decw$xmulibshr.exe/share"
  @ WRITE_ FILE "SYS$SHARE:DECW$XEXTLIBSHR/SHARE"
  @ WRITE_ FILE "SYS$SHARE:DECW$XLIBSHR/SHARE"
  @ CLOSE_ FILE
  @ WRITE_ SYS$OUTPUT "  generating mesagl.map ..."
  @ CXXLINK_/NODEB/NOSHARE/NOEXE/MAP=mesagl.map/FULL mesagl1.opt/OPT
  @ WRITE_ SYS$OUTPUT "  analyzing mesagl.map ..."
  @ @[-.vms]ANALYZE_MAP.COM mesagl.map mesagl.opt
  @ WRITE_ SYS$OUTPUT "  linking $(GLUT_LIB) ..."
  @ CXXLINK_/NODEB/SHARE=$(GLUT_LIB)/MAP=mesagl.map/FULL mesagl1.opt/opt,mesagl.opt/opt
.else
  @ $(MAKELIB) $(GLUT_LIB) $(OBJECTS)
  @ library $(GLUT_LIB) $(OBJECTS1)
  @ library $(GLUT_LIB) $(OBJECTS2)
  @ library $(GLUT_LIB) $(OBJECTS3)
.endif
  @ rename $(GLUT_LIB)* $(LIBDIR)

clean :
	delete *.obj;*
	purge

include mms_depend.
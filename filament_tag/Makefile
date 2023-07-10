# Please keep alphabetical.  Note that the 5-letter tags 
# are only made in the wide version.
STLS = \
       filament_tag_ABS.stl \
       filament_tag_ASA.stl \
       filament_tag_CPE.stl \
       filament_tag_EDGE.stl \
       filament_tag_FLEX.stl \
       filament_tag_HIPS.stl \
       filament_tag_NGEN.stl \
       filament_tag_PA.stl \
       filament_tag_PC.stl \
       filament_tag_PCTG.stl \
       filament_tag_PEBA.stl \
       filament_tag_PET.stl \
       filament_tag_PETG.stl \
       filament_tag_PETT.stl \
       filament_tag_PLA.stl \
       filament_tag_PMMA.stl \
       filament_tag_PP.stl \
       filament_tag_POM.stl \
       filament_tag_PVA.stl \
       filament_tag_PVB.stl \
       filament_tag_blank.stl\
\
       filament_tag_wide_ABS.stl \
       filament_tag_wide_ASA.stl \
       filament_tag_wide_CPE.stl \
       filament_tag_wide_EDGE.stl \
       filament_tag_wide_FLEX.stl \
       filament_tag_wide_HIPS.stl \
       filament_tag_wide_HTPLA.stl \
       filament_tag_wide_LWPLA.stl \
       filament_tag_wide_METAL.stl \
       filament_tag_wide_NGEN.stl \
       filament_tag_wide_PA.stl \
       filament_tag_wide_PC.stl \
       filament_tag_wide_PCTG.stl \
       filament_tag_wide_PEBA.stl \
       filament_tag_wide_PET.stl \
       filament_tag_wide_PETG.stl \
       filament_tag_wide_PETT.stl \
       filament_tag_wide_PLA.stl \
       filament_tag_wide_PMMA.stl \
       filament_tag_wide_PP.stl \
       filament_tag_wide_POM.stl \
       filament_tag_wide_PVA.stl \
       filament_tag_wide_PVB.stl \
       filament_tag_wide_blank.stl


all: ${STLS}

filament_tag_blank.stl: filament_tag.scad
	openscad -D 'TEXT=""' -D 'WIDTH_MM=35' -o $@ filament_tag.scad

filament_tag_%.stl: filament_tag.scad
	openscad -D 'TEXT="$*"' -D 'WIDTH_MM=35' -o $@ filament_tag.scad 

filament_tag_wide_blank.stl: filament_tag.scad
	openscad -D 'TEXT=""' -D 'WIDTH_MM=50' -o $@ filament_tag.scad

filament_tag_wide_%.stl: filament_tag.scad
	openscad -D 'TEXT="$*"' -D 'WIDTH_MM=50' -o $@ filament_tag.scad


clean:
	rm -f *.stl



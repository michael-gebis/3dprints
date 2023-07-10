# Please keep alphabetical.  Note that the 5-letter tags 
# are only made in the wide version.
STLS = \
    	dowel_tab_7.0mm.stl \
	dowel_tab_7.5mm.stl \
	dowel_tab_8.0mm.stl \
	dowel_tab_8.5mm.stl \
	dowel_tab_9.0mm.stl \
	dowel_tab_9.5mm.stl \
	dowel_tab_10.0mm.stl \
	dowel_tab_10.5mm.stl \
	dowel_tab_11.0mm.stl \
	dowel_tab_11.5mm.stl \
	dowel_tab_12.0mm.stl \
	dowel_tab_12.5mm.stl \
	dowel_tab_13.0mm.stl

all: ${STLS}

dowel_tab_%mm.stl: dowel_tab.scad
	openscad -D 'HOLE_DIA_MM=$*' -o $@ dowel_tab.scad

clean:
	rm -f *.stl

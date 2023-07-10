STLS = \
	mk3_sheet_holder_1_slots_left.stl \
	mk3_sheet_holder_2_slots_left.stl \
	mk3_sheet_holder_3_slots_left.stl \
	mk3_sheet_holder_4_slots_left.stl \
	mk3_sheet_holder_5_slots_left.stl \
	mk3_sheet_holder_6_slots_left.stl \
	mk3_sheet_holder_1_slots_right.stl \
	mk3_sheet_holder_2_slots_right.stl \
	mk3_sheet_holder_3_slots_right.stl \
	mk3_sheet_holder_4_slots_right.stl \
	mk3_sheet_holder_5_slots_right.stl \
	mk3_sheet_holder_6_slots_right.stl

all: ${STLS}

mk3_sheet_holder_%_slots_left.stl: sheet_holder.scad
	openscad -D DO_LEFT=true -D DO_RIGHT=false -D NUM_SLOTS=$* -o $@ sheet_holder.scad 

mk3_sheet_holder_%_slots_right.stl: sheet_holder.scad
	openscad -D DO_LEFT=false -D DO_RIGHT=true -D NUM_SLOTS=$* -o $@ sheet_holder.scad 

clean:
	rm -f *.stl



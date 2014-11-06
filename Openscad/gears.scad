include <parametric_involute_gear_v5.0.scad>
//small gear was 9tooth, 200pitch
//large gear was 53tooth, 200pitch

//small gear was 9tooth, 260pitch
//large gear was 39tooth, 260pitch

shaft_flat = 2;      // Radial distance of D flat on the shaft from its axis.  Set to...
motor_shaft = 5.0;

//rotate([180,0,0]) translate([0,0,-7])
//translate ([19.9028,0,1]) //was translate ([19.2588,0,1])
//translate([0,50,0])
//	large_gear();
//translate([10,10,0])
//rotate([0,0,0]) translate([0,0,-3]) rotate([0,0,0])
	//color([1,1,1,0.3])
		small_gear();

module small_gear(){
translate ([0,0,0])
	difference(){
		union() {
			gear (
				number_of_teeth=13,
				circular_pitch=150, diametral_pitch=false, // Changed from 150 - AB
				pressure_angle=28,
				clearance = 0.2,
				gear_thickness=5,
				rim_thickness=6,
				rim_width=6,
				hub_thickness=4,
				hub_diameter=13,
				bore_diameter=motor_shaft,
				circles=0,
				backlash=0,
				twist=0,
				involute_facets=0
			);
			
			translate([shaft_flat + 0.75,0,3])
				cube([1.5,5,6],center=true);
			//base
			difference(){
				union(){
					cylinder(r=6.3,h=1.0,$fn=64);			
					//translate([0,0,0.4]) cylinder(r1=6.3,r2=5.3,h=0.4,$fn=64);
				}
				cylinder(r=motor_shaft/2,h=1.001,$fn=64);
			}
		}
		//lead in
		translate([0,0,-0.01])
			cylinder(r1=motor_shaft/2+0.25, r2=motor_shaft/2-2,h=4,$fn=64);
	}
}

module large_gear(){
difference(){
	union(){
		translate([0,0,-1.01]) cylinder(r=28,h=8,$fn=128);
		//translate([0,0,-2.999]) cylinder(r2=5.5,r1=3,h=3);
	}
	translate([0,0,-1.02]) gear (
	number_of_teeth=61,
	circular_pitch=150, diametral_pitch=false,  // Changed from 150 - AB
	pressure_angle=28,
	clearance = 0.2,
	gear_thickness=0.01,
	rim_thickness=5,
	rim_width=3,
	hub_thickness=0,
	hub_diameter=4,
	bore_diameter=1,
	circles=0,
	backlash=0,
	twist=0,
	involute_facets=0);
	
	//cylinder(r=3.3/2,h=40,center=true);
	//polyhole(40,3);
	//cylinder(r=3/2,h=40,$fn=24);
	translate([0,0,4.5]) cylinder(h=6, r=5.4/sqrt(3),$fn=6);
	cylinder(r=2.95/sqrt(3),h=40,center=true,$fn=6);
	difference(){
		cylinder(r=22.5,h=20,center=true,$fn=128); 
		translate([0,0,2.5]) cylinder(r=5.5,h=7.5,$fn=64);
		translate([0,0,0.51]) cylinder(r2=5.5,r1=2.5,h=2);
		for(i=[0:5])
		rotate([0,0,i*360/5])
		translate([0,15,5.5]) {
			difference() {
			    cube([6,30,3],center=true);
			    for(k=[1,0]){
    			    mirror([k,0,0]) translate([2.5,0,-1.5]) rotate([0,60,0]) cube([1,30,4], center=true);
    			}
			 }
		}
	}
}
	translate([0,0,4.5]) cylinder(r=4,h=0.25);

}

module polyhole(h, d) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}


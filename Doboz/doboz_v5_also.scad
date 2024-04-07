//color("red",0.8) translate([0,0,-1.5]) import("doboz_v4-Also2.stl");
//color("pink",0.8)translate([0,0,-1.5]) import("doboz_v4-Felso2.stl");

//color("lightblue",0.8) translate([0,0,14.5]) import("doboz_v5_felso.stl");

$fn=100;

color("#b0b0b0",0.8)
render(){


difference(){//alsó rész mínusz felső rész
	//alsó rész:
	union(){
		//belső lenti perem #1:
		translate([16,-42.5,1.5])
			cube([2,85,2], center=false);
		//belső lenti perem 2#:
		translate([-18,-42.5,1.5])
			cube([2,85,2], center=false);
		
		render()
		difference(){
			union(){
				translate([0,0,8.5])
					cube([40,90,20], center=true);

				translate([0,45,0])
					difference(){
						cylinder(r=10,h=3,center=true);
						translate([0,4.5,0])
							cylinder(r=3,h=10,center=true);
					}

				translate([0,-45,0])
					difference(){
						cylinder(r=10,h=3,center=true);
						translate([0,-4.5,0])
							cylinder(r=3,h=10,center=true);
					}
			}
			
			//oldalfalból kivágott hely csatlakozóknak
			translate([-15.4,-45.001,1.5])
				cube([23,2.502,30],center=false);
			
			//középső üreg:
			translate([-18,-42.5,1.5])
				cube([36,85,40], center=false);
		}
		//felső részt alulról tartó háromszög sávok:
		translate([-18,7,10.5])
			rotate([90,0,0])
				linear_extrude(52)
				polygon([ [0,0], [1.5,3], [1.5,4], [0,4] ]);
		mirror([1,0,0])
		translate([-18,7,10.5])
			rotate([90,0,0])
				linear_extrude(52)
				polygon([ [0,0], [1.5,3], [1.5,4], [0,4] ]);
		//felső részt felülrőlról tartó háromszög sávok:
		translate([-18.5,7,15.5])
			rotate([90,0,0])
				linear_extrude(52)
				polygon([ [0,0], [1,2], [1,3], [0,3] ]);
		mirror([1,0,0])
		translate([-18.5,7,15.5])
			rotate([90,0,0])
				linear_extrude(52)
				polygon([ [0,0], [1,2], [1,3], [0,3] ]);
	}
	
	//felső rész trapéz-szerű alapja a kivonáshoz:
	union(){
		translate([0,7,14.5])
			rotate([90,0,0])
				linear_extrude(52)
				polygon([ [-18.5,0], [18.5,0], [18.5,1], [17.5,3], [17.5,4], [-17.5,4], [-17.5, 3], [-18.5,1] ]);
	}
}//alsó rész mínusz felső rész

//fél hengerek a rögzítéshez:
translate([19,-43,15.5])
	difference(){
		cylinder(r=1.5, h=4, center=true);
		translate([0,-5,-5])cube([10,10,10]);
	}
mirror([1,0,0])
translate([19,-43,15.5])
	difference(){
		cylinder(r=1.5, h=4, center=true);
		translate([0,-5,-5])cube([10,10,10]);
	}


}//render


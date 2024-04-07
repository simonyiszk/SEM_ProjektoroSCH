//import("C:/SEM_Simonyi/SEM_ProjektoroSCH-main/Doboz/doboz_v5_also.scad");

$fn=100;

//Mennyivel legyen keskenyebb a nyomtatott felső darab az alsóban neki kialakított helynél? Ha nem fér be, feszül, akkor növeld az értéket.
$oldalso_kisebbites=0.05;

color("#b0b0b0",0.8)
render(){


difference(){
	//trapéz-szerű alap:
	union(){
		translate([0,7,0])
			rotate([90,0,0])
				linear_extrude(52)
				polygon([ 
					[-18.5+$oldalso_kisebbites,0],
					[18.5-$oldalso_kisebbites,0],
					[18.5-$oldalso_kisebbites,1],
					[17.5-$oldalso_kisebbites,3],
					[17.5-$oldalso_kisebbites,4],
					[-17.5+$oldalso_kisebbites,4],
					[-17.5+$oldalso_kisebbites, 3],
					[-18.5+$oldalso_kisebbites,1] ]);
	}

	//fél hengerek a rögzítéshez:
	translate([19-$oldalso_kisebbites,-43,1.5])
		difference(){
			cylinder(r=1.5, h=4, center=true);
			translate([0,-5,-5])cube([10,10,10]);
		}
	mirror([1,0,0])
	translate([19-$oldalso_kisebbites,-43,1.5])
		difference(){
			cylinder(r=1.5, h=4, center=true);
			translate([0,-5,-5])cube([10,10,10]);
		}
	//bevágások a hajlékonysághoz a rögzítésnél
	translate([15-$oldalso_kisebbites,-45,0])
		cube([1,15,4]);
	mirror([1,0,0])
	translate([15-$oldalso_kisebbites,-45,0])
		cube([1,15,4]);
}


}//render


//OpenSCAD source code
//https://openscad.org

//import("C:/SEM_Simonyi/SEM_ProjektoroSCH-main/Doboz/doboz_v5_also.scad");

$fn=100;

//Mennyivel legyen keskenyebb a nyomtatott felső darab az alsóban neki kialakított helynél? Ha nem fér be, feszül, akkor növeld az értéket.
$oldalso_kisebbites=0.05;

$lekerekites=1;
$belso_hossz=85;
$belso_szel=40;
$kulso_mag=20;
$anyagvastagsag_oldalfal=2;
$anyagvastagsag_alja=3;
$henger_atmero=14;
$henger_luk=3;
$felso_resz_hossz=49; //+anyagvastagsag_oldalfal

translate([0,-$belso_hossz/2-$anyagvastagsag_oldalfal,16])
color("#b0b0b0",0.8)
render(){
//TODO: hosszúság rövidebbre vétele, hogy biztosan bepattanjon

difference(){
	//trapéz-szerű alap:
	union(){
		translate([0,$felso_resz_hossz+$anyagvastagsag_oldalfal,0])
			rotate([90,0,0])
				linear_extrude($felso_resz_hossz+$anyagvastagsag_oldalfal)
				polygon([ 
					[-$belso_szel/2-0.5+$oldalso_kisebbites,0],
					[+$belso_szel/2+0.5-$oldalso_kisebbites,0],
					[+$belso_szel/2+0.5-$oldalso_kisebbites,1],
					[+$belso_szel/2-0.5-$oldalso_kisebbites,3],
					[+$belso_szel/2-0.5-$oldalso_kisebbites,4],
					[-$belso_szel/2+0.5+$oldalso_kisebbites,4],
					[-$belso_szel/2+0.5+$oldalso_kisebbites, 3],
					[-$belso_szel/2-0.5+$oldalso_kisebbites,1] ]);
		//csatlakozókat leszorító kiálló rész az alján
		translate([-13,0,0])
			rotate([90,0,0])
			rotate([0,90,0])
				linear_extrude(15)
				polygon([ 
					[0,0],
					[1,-2.5],
					[4,-2.5],
					[7,0] ]);
	}

	//fél henger pöckök a rögzítéshez:
	translate([19-$oldalso_kisebbites,2,1.5])
		difference(){
			cylinder(r=1.5, h=4, center=true);
			translate([0,-5,-5])cube([10,10,10]);
		}
	mirror([1,0,0])
	translate([19-$oldalso_kisebbites,2,1.5])
		difference(){
			cylinder(r=1.5, h=4, center=true);
			translate([0,-5,-5])cube([10,10,10]);
		}
	//bevágások a hajlékonysághoz a rögzítésnél
	translate([0.42*$belso_szel-$oldalso_kisebbites,0,0])
		cube([1,15,4]);
	mirror([1,0,0])
	translate([0.42*$belso_szel-$oldalso_kisebbites,0,0])
		cube([1,15,4]);
	//felső lekerekítés a elejénél:
	translate([0,$lekerekites/2,3+$lekerekites/2])
		rotate([0,180,-90])
			el_lekerekites_negativ($lekerekites,$belso_szel+2*$anyagvastagsag_oldalfal);
}


}//render

module sarok_legombolyites_negativ(r,center=true){
	if(center==true){
		translate([r/2,r/2,r/2])
		rotate([0,90,180])
			difference(){
				cube(r);
				sphere(r);
			}
	}else if(center==false){
		rotate([0,90,180])
			difference(){
				cube(r);
				sphere(r);
			}
	}
}
module el_lekerekites_negativ(r,hossz,center=true){
	if(center==true){
	translate([r/2,-hossz/2,r/2])
		rotate([0,180,0])
			difference(){
			cube([r,hossz,r]);
			translate([0,-0.5,0])
				rotate([-90,0,0])
					cylinder(hossz+1, r, r);
			}
	}else if(center==false){
	translate([0,0,0])
		rotate([0,180,0])
			difference(){
			cube([r,hossz,r]);
			translate([0,-0.5,0])
				rotate([-90,0,0])
					cylinder(hossz+1, r, r);
			}
	}
}
//OpenSCAD source code
//https://openscad.org

//color("red",0.8) translate([0,0,0]) import("doboz_v4-Also2.stl");
//color("pink",0.8)translate([0,0,0]) import("doboz_v4-Felso2.stl");

color("lightgreen",0.8)translate([0,0,0]) import("doboz_v4-elektronika_3d.stl");

color("lightblue",0.8) translate([0,0,0]) import("doboz_v6_felso.stl");



//HA JOBBAN ÁT SZERETNÉD LÁTNI MI HOGY VAN, KAPCSOLD BE EZEKET:
$ATTEKINTO_NEZET=false;
$FELBEVAGOTT_NEZET=false;

$fn=15; //ÍV FELBONTÁS - STL-BE EXPORTÁLÁS ELŐTT VEDD FEL PL. 100-ra!
//(jelentősen több ideig fog generálni, úgyhogy: kikommenteled az importokat, átírod $fn=100-ra, rányomsz a "render" gombra (vagy F6), megvárod míg legenerálja, File->Export, aztán Ctrl+Z)

//Szélesség állításnál az alsó nyáktartó peremeket kézzel kell igazítani
//
//A felső rész módosításakor ne felejtsd el átmásolni innen a konstansokat!
//

$lekerekites=1;
$belso_hossz=85;
$belso_szel=40;
$kulso_mag=20;
$anyagvastagsag_oldalfal=2;
$anyagvastagsag_alja=3;
$henger_atmero=14;
$henger_luk=3;
$felso_resz_hossz=49; //+anyagvastagsag_oldalfal

color("#b0b0b0",0.8)
render(){


difference(){//alsó rész mínusz felső rész
	//alsó rész:
	union(){
		
		
		difference(){
			union(){
				//alap téglatest, amiből ki lesz vonva a belső rész:
				translate([0,0,10])
				if($ATTEKINTO_NEZET==false)
					cube([$belso_szel+2*$anyagvastagsag_oldalfal,$belso_hossz+2*$anyagvastagsag_oldalfal,$kulso_mag], center=true);

				//fél hengerek a talpon a rögzítéshez:
				translate([0,$belso_hossz/2+$anyagvastagsag_oldalfal,$anyagvastagsag_alja/2])
					difference(){
						cylinder(r=$henger_atmero,h=$anyagvastagsag_alja,center=true);
						translate([0,4.5,0])
							cylinder(r=$henger_luk,h=$anyagvastagsag_alja,center=true);
					}
				translate([0,-$belso_hossz/2-$anyagvastagsag_oldalfal,$anyagvastagsag_alja/2])
					difference(){
						cylinder(r=$henger_atmero,h=$anyagvastagsag_alja,center=true);
						translate([0,-4.5,0])
							cylinder(r=$henger_luk,h=$anyagvastagsag_alja,center=true);
					}
			}
			
			//oldalfalból kivágott hely csatlakozóknak
			translate([-15.4,-45.001,$anyagvastagsag_alja])
				cube([23,2.502,30],center=false);
			
			//középső üreg:
			translate([0,0,$anyagvastagsag_alja+1000/2])
				cube([$belso_szel,$belso_hossz,1000], center=true);
			//lekerekítések:
			{
			//bal oldal:
			
			//alsó lekerekítések:
			translate([(-$belso_szel/2)-$anyagvastagsag_oldalfal+$lekerekites/2,0,$lekerekites/2])
				el_lekerekites_negativ($lekerekites,$belso_hossz+2*$anyagvastagsag_oldalfal);
			translate([-$belso_szel/2,-$belso_hossz/2-$anyagvastagsag_oldalfal+$lekerekites/2,$lekerekites/2])
				rotate([0,0,90])
					el_lekerekites_negativ($lekerekites,2*($belso_szel/2-$henger_atmero));
			translate([-$belso_szel/2,+$belso_hossz/2+$anyagvastagsag_oldalfal-$lekerekites/2,$lekerekites/2])
				rotate([0,0,-90])
					el_lekerekites_negativ($lekerekites,2*($belso_szel/2-$henger_atmero));
			translate([-$belso_szel/2-$anyagvastagsag_oldalfal+$lekerekites/2,-$belso_hossz/2-$anyagvastagsag_oldalfal/2-$lekerekites/2,$lekerekites/2])
				rotate([0,0,0])
					sarok_legombolyites_negativ($lekerekites);
			translate([-$belso_szel/2-$anyagvastagsag_oldalfal+$lekerekites/2,+$belso_hossz/2+$anyagvastagsag_oldalfal/2+$lekerekites/2,$lekerekites/2])
				rotate([0,0,-90])
					sarok_legombolyites_negativ($lekerekites);
			//oldalsó lekerekítések:
			translate([-$belso_szel/2-$anyagvastagsag_oldalfal+$lekerekites/2,-$belso_hossz/2-$anyagvastagsag_oldalfal+$lekerekites/2,$kulso_mag/2])
				rotate([90,0,90])
					el_lekerekites_negativ($lekerekites,$kulso_mag);
			translate([-$belso_szel/2-$anyagvastagsag_oldalfal+$lekerekites/2,+$belso_hossz/2+$anyagvastagsag_oldalfal-$lekerekites/2,$kulso_mag/2])
				rotate([90,0,0])
					el_lekerekites_negativ($lekerekites,$kulso_mag);
			//felső lekerekítések:
			translate([(-$belso_szel/2)-$anyagvastagsag_oldalfal+$lekerekites/2,0,$kulso_mag-$lekerekites/2])
				rotate([0,90,0])
					el_lekerekites_negativ($lekerekites,$belso_hossz+2*$anyagvastagsag_oldalfal);
			translate([-$belso_szel/2-$anyagvastagsag_oldalfal,-$belso_hossz/2-$anyagvastagsag_oldalfal+$lekerekites/2,$kulso_mag-$lekerekites/2])
				rotate([0,90,90])
					el_lekerekites_negativ($lekerekites,$belso_szel/2+$anyagvastagsag_oldalfal);
			translate([0,+$belso_hossz/2+$anyagvastagsag_oldalfal-$lekerekites/2,$kulso_mag-$lekerekites/2])
				rotate([0,90,-90])
					el_lekerekites_negativ($lekerekites,$belso_szel+2*$anyagvastagsag_oldalfal);
			translate([-$belso_szel/2-$anyagvastagsag_oldalfal+$lekerekites/2,-$belso_hossz/2-$anyagvastagsag_oldalfal/2-$lekerekites/2,$kulso_mag-$lekerekites/2])
				rotate([0,90,0])
					sarok_legombolyites_negativ($lekerekites);
			translate([-$belso_szel/2-$anyagvastagsag_oldalfal+$lekerekites/2,+$belso_hossz/2+$anyagvastagsag_oldalfal/2+$lekerekites/2,$kulso_mag-$lekerekites/2])
				rotate([0,90,-90])
					sarok_legombolyites_negativ($lekerekites);
			
			
			//jobb oldal:
			mirror([1,0,0]){
			
			//alsó lekerekítések:
			translate([(-$belso_szel/2)-$anyagvastagsag_oldalfal+$lekerekites/2,0,$lekerekites/2])
				el_lekerekites_negativ($lekerekites,$belso_hossz+2*$anyagvastagsag_oldalfal);
			translate([-$belso_szel/2,-$belso_hossz/2-$anyagvastagsag_oldalfal+$lekerekites/2,$lekerekites/2])
				rotate([0,0,90])
					el_lekerekites_negativ($lekerekites,2*($belso_szel/2-$henger_atmero));
			translate([-$belso_szel/2,+$belso_hossz/2+$anyagvastagsag_oldalfal-$lekerekites/2,$lekerekites/2])
				rotate([0,0,-90])
					el_lekerekites_negativ($lekerekites,2*($belso_szel/2-$henger_atmero));
			translate([-$belso_szel/2-$anyagvastagsag_oldalfal+$lekerekites/2,-$belso_hossz/2-$anyagvastagsag_oldalfal/2-$lekerekites/2,$lekerekites/2])
				rotate([0,0,0])
					sarok_legombolyites_negativ($lekerekites);
			translate([-$belso_szel/2-$anyagvastagsag_oldalfal+$lekerekites/2,+$belso_hossz/2+$anyagvastagsag_oldalfal/2+$lekerekites/2,$lekerekites/2])
				rotate([0,0,-90])
					sarok_legombolyites_negativ($lekerekites);
			//oldalsó lekerekítések:
			translate([-$belso_szel/2-$anyagvastagsag_oldalfal+$lekerekites/2,-$belso_hossz/2-$anyagvastagsag_oldalfal+$lekerekites/2,$kulso_mag/2])
				rotate([90,0,90])
					el_lekerekites_negativ($lekerekites,$kulso_mag);
			translate([-$belso_szel/2-$anyagvastagsag_oldalfal+$lekerekites/2,+$belso_hossz/2+$anyagvastagsag_oldalfal-$lekerekites/2,$kulso_mag/2])
				rotate([90,0,0])
					el_lekerekites_negativ($lekerekites,$kulso_mag);
			//felső lekerekítések:
			translate([(-$belso_szel/2)-$anyagvastagsag_oldalfal+$lekerekites/2,0,$kulso_mag-$lekerekites/2])
				rotate([0,90,0])
					el_lekerekites_negativ($lekerekites,$belso_hossz+2*$anyagvastagsag_oldalfal);
			translate([-$belso_szel/2-$anyagvastagsag_oldalfal,-$belso_hossz/2-$anyagvastagsag_oldalfal+$lekerekites/2,$kulso_mag-$lekerekites/2])
				rotate([0,90,90])
					el_lekerekites_negativ($lekerekites,$belso_szel/2+$anyagvastagsag_oldalfal);
			translate([0,+$belso_hossz/2+$anyagvastagsag_oldalfal-$lekerekites/2,$kulso_mag-$lekerekites/2])
				rotate([0,90,-90])
					el_lekerekites_negativ($lekerekites,$belso_szel+2*$anyagvastagsag_oldalfal);
			translate([-$belso_szel/2-$anyagvastagsag_oldalfal+$lekerekites/2,-$belso_hossz/2-$anyagvastagsag_oldalfal/2-$lekerekites/2,$kulso_mag-$lekerekites/2])
				rotate([0,90,0])
					sarok_legombolyites_negativ($lekerekites);
			translate([-$belso_szel/2-$anyagvastagsag_oldalfal+$lekerekites/2,+$belso_hossz/2+$anyagvastagsag_oldalfal/2+$lekerekites/2,$kulso_mag-$lekerekites/2])
				rotate([0,90,-90])
					sarok_legombolyites_negativ($lekerekites);
			}//mirror (lekerekítések)
			}//lekerekítések
		}//difference
		//felső részt alulról tartó háromszög sávok:
		translate([-$belso_szel/2-0,7,12])
			rotate([90,0,0])
				linear_extrude(50)
				polygon([ [0,0], [1.5,3], [1.5,4], [0,4] ]);
		mirror([1,0,0])
		translate([-$belso_szel/2-0,7,12])
			rotate([90,0,0])
				linear_extrude(50)
				polygon([ [0,0], [1.5,3], [1.5,4], [0,4] ]);
		//felső részt felülrőlról tartó háromszög sávok:
		translate([-$belso_szel/2-0.5,7,17])
			rotate([90,0,0])
				linear_extrude(50)
				polygon([ [0,0], [1,2], [1,3], [0,3] ]);
		mirror([1,0,0])
		translate([-$belso_szel/2-0.5,7,17])
			rotate([90,0,0])
				linear_extrude(50)
				polygon([ [0,0], [1,2], [1,3], [0,3] ]);
		//belső perem lent két oldalt:
		$perem_szel=4.5;
		$perem_mag=2;
		translate([-$belso_szel/2+$perem_szel/2,0,+$anyagvastagsag_alja+$perem_mag/2])
			cube([$perem_szel,85,2], center=true);
		translate([+$belso_szel/2-$perem_szel/2,0,+$anyagvastagsag_alja+$perem_mag/2])
			cube([$perem_szel,85,2], center=true);
		//nyákleszorító bent lent a hátuljánál:
		translate([-$belso_szel/2,$belso_hossz/2,$anyagvastagsag_alja+3])
			rotate([90,0,0])
			rotate([0,90,0])
				linear_extrude($belso_szel)
				polygon([ [0,0], [1,0], [1,5], [-1,3], [-1,1.5] ]);
	}//union
	
	//felső rész trapéz-szerű alapja a kivonáshoz:
	//(Kivonás csak a doboz elejéből. A csúsztatósínek polygon-ként vannak létrehozva lentebb)
	union(){
		translate([0,7,16])
			rotate([90,0,0])
				linear_extrude(52)
				polygon([ 
					[-$belso_szel/2-0.5,0],
					[+$belso_szel/2+0.5,0],
					[+$belso_szel/2+0.5,1],
					[+$belso_szel/2-0.5,3],
					[+$belso_szel/2-0.5,4],
					[-$belso_szel/2+0.5,4],
					[-$belso_szel/2+0.5, 3],
					[-$belso_szel/2-0.5,1] ]);
	}
	
	//FÉLBEVÁGÓ/BETEKINTŐ - HA AZ OLDALÁT LE AKAROD SZEDNI:
	if($FELBEVAGOTT_NEZET==true)
		translate([5000,0,0]) cube([10000,10000,10000],center=true);
	
}//difference: alsó rész mínusz felső rész

//felső részt becsúsztatáskor rögzítő félhenger alakú pöckök:
translate([-$belso_szel/2-1,-$belso_hossz/2-$anyagvastagsag_oldalfal+2,17])
	difference(){
		cylinder(r=1.5, h=4, center=true);
		translate([-5,0,0])cube([10,10,10],center=true);
	}
mirror([1,0,0])
translate([-$belso_szel/2-1,-$belso_hossz/2-$anyagvastagsag_oldalfal+2,17])
	difference(){
		cylinder(r=1.5, h=4, center=true);
		translate([-5,0,0])cube([10,10,10],center=true);
	}
//nyákot oldalról rögzítő hengerek:
translate([-$belso_szel/2-1,27,$kulso_mag/2])
	difference(){
		cylinder(r=2.5, h=$kulso_mag, center=true);
		translate([-4,0,0])cube([10,10,10000],center=true);
	}
mirror([1,0,0])
translate([-$belso_szel/2-1,27,$kulso_mag/2])
	difference(){
		cylinder(r=2.5, h=$kulso_mag, center=true);
		translate([-4,0,0])cube([10,10,10000],center=true);
	}
translate([-$belso_szel/2-1,-35,7.5])
	difference(){
		cylinder(r=2.5, h=15, center=true);
		translate([-4,0,0])cube([10,10,10000],center=true);
	}
mirror([1,0,0])
translate([-$belso_szel/2-1,-35,7.5])
	difference(){
		cylinder(r=2.5, h=15, center=true);
		translate([-4,0,0])cube([10,10,10000],center=true);
	}
//gomboknál szélső takaró fent:
translate([-$belso_szel/2,$belso_hossz/2,15])
	rotate([90,0,0])
		linear_extrude(35.5)
		polygon([ [0,0], [2,3], [2,5], [0,5] ]);
mirror([1,0,0])
translate([-$belso_szel/2,$belso_hossz/2,15])
	rotate([90,0,0])
		linear_extrude(35.5)
		polygon([ [0,0], [2,3], [2,5], [0,5] ]);
translate([+$belso_szel/2,$belso_hossz/2,15])
	rotate([90,0,-90])
		linear_extrude($belso_szel)
		#polygon([ [0,0], [1,3], [1,5], [0,5] ]);
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


module supported_cylinder(r=-1,d=-1,d1=-1,d2=-1,h,center=false,bridgelength=4,supportthickness=0.6,supportgap=.25,) {
    
    ra=r;
    da=d<0?ra*2:d;
    d1a=d1<0?da:d1;
    d2a=d2<0?d1a:d2;
    
    if (d1a>0 && d2a>0 && h > 0) {
        translate([0,0,center?-h/2:0]) difference() {
            dr=(d1a-d2a)/h;
            dm=max(d1a,d2a);
            echo (dr,dm);
            cylinder(d1=d1a,d2=d2a,h=h);
            
            translate([0,0,bridgelength]) cylinder(d1=d1a/4,d2=d2a/4,h=h-2*bridgelength);
            
            supportcount=ceil((h-bridgelength)/(supportthickness+bridgelength));
            supportspacing = (h-bridgelength)/supportcount;
            
            for (i=[1:supportcount]) {
                z=supportspacing*i-supportthickness;
                zs=supportspacing*i-supportthickness;
                ze=supportspacing*i;
                ds=d1a-dr*zs-supportgap*2;
                de=d1a-dr*ze-supportgap*2;
                echo (zs,ds,ze,de);
                
                translate([0,0,zs]) cylinder(d1=ds,d2=de,h=supportthickness);
            }
        }
    }
}
difference() {
    cube([100,20,50]);
translate([20,0,5]) supported_cylinder(r=8,h=40);
translate([40,0,5]) supported_cylinder(d=8,h=40);
translate([60,0,5]) supported_cylinder(d1=8,d2=16,h=40);
translate([80,0,5]) supported_cylinder(d1=16,d2=8,h=40);
}
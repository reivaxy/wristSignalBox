// wrist signal



innerWidth = 30;
innerLength = 40;
innerHeight = 11.5;

wall = 1;
radius = 3;

slotHeight = wall+0.5;
slotLength = 10;
pillarWidth=3;
pillarHeight = innerHeight - 0.3;

bigTabWidth = 2;
bigTabLength = 10;
tabHeight = wall*0.4;
smallTabLength = 5;
smallTabWidth = 1;

tolerance = 0.05;


wristSignalBox();

translate([innerWidth + 2*wall + 2, 0, 0]) {
  cover();
}

//translate([wall + tolerance, wall + tolerance, innerHeight]) {
//  cover();
//}

module cover() {
  width = innerWidth - 2*tolerance;
  length = innerLength - 2*tolerance;
  coverTabLength = slotLength - 2*tolerance;
  
  color("Aqua")
  difference() {
    union() {
      roundedSolid(width, length, wall, radius);
      translate([innerWidth - 3*wall, (length - coverTabLength)/2 , height - slotHeight]) {
        cube([wall * 5, coverTabLength, wall]);
      }
    }
    
    // Slot for big tab
    bigSlotLength = bigTabLength + 4*tolerance;
    translate([-1, (length - bigSlotLength)/2, wall/2]) {
      cube([bigTabWidth + 2*tolerance, bigSlotLength, tabHeight * 2]);
    } 

    // Slots for small tabs
    smallSlotLength = smallTabLength + 4*tolerance;
    translate([width - smallTabWidth, (innerLength + 2*wall + 6 * tolerance - smallSlotLength )/5 - wall - 4*tolerance, wall/2]) {
      cube([smallTabWidth, smallSlotLength, tabHeight*2]);
    }    
    translate([width - smallTabWidth , (innerLength + 2*wall + 5 * tolerance - smallSlotLength )*4/5 - wall - 4*tolerance, wall/2]) {
      cube([smallTabWidth, smallSlotLength, tabHeight*2]);
    }    
  }
}


module wristSignalBox() {
  width = innerWidth + 2 * wall;
  length = innerLength + 2 * wall;
  height = innerHeight + 2 * wall;
  
  difference() {
    roundedSolid(width, length, height, radius); 
    translate([wall, wall, wall]) 
      roundedSolid(innerWidth , innerLength, height, radius); 
    translate([innerWidth - wall, (length - slotLength)/2 , height - slotHeight]) {
      cube([wall * 4, slotLength, slotHeight + 1]);
    }
  }
  
  // pilars
  translate([wall, wall, wall]) {
    cube([pillarWidth, pillarWidth, pillarHeight]);
  }
  translate([wall, length - wall -pillarWidth, wall]) {
    cube([pillarWidth, pillarWidth, pillarHeight]);
  }
  translate([innerWidth - 2* wall, wall, wall]) {
    cube([pillarWidth, pillarWidth, pillarHeight]);
  }
  translate([innerWidth - 2* wall, length - wall -pillarWidth, wall]) {
    cube([pillarWidth, pillarWidth, pillarHeight]);
  }
  
  // big tab
  translate([0, (length - bigTabLength)/2, height - tabHeight]) {
    cube([bigTabWidth, bigTabLength, tabHeight]);
  }
  
  // Small tabs
  translate([innerWidth + smallTabWidth/2, (length - smallTabLength)/5, height - tabHeight]) {
    cube([smallTabWidth, smallTabLength, tabHeight]);
  }    
  translate([innerWidth + smallTabWidth/2, (length - smallTabLength)*4/5, height - tabHeight]) {
    cube([smallTabWidth, smallTabLength, tabHeight]);
  } 

}

module roundedSolid(width, length, height, radius) {
  rectWidth = width - 2*radius;
  rectLength = length - 2*radius;

  translate([radius, radius, 0]) {
    if(radius == 0) {
      cube([rectWidth, rectLength, height]);
    } else {
      // minkowski adds heights too.
      eachHeight = height /2;
      minkowski() {
        cube([rectWidth, rectLength, eachHeight]);
        cylinder(r=radius, h=eachHeight, $fn=80);
      } 
    }
  }
  
}
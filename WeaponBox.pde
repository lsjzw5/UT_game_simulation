class WeaponBox{
  //position variables
  float x,y;
  float radius;
  int boxNumber;
  
  //weapon associated with box
  PImage weapImg;
  
  //selected 
  boolean isSelected;
  
  //amount of ammo for the weapon
  int ammoCount;

  WeaponBox(float _x, float _y, int num, float rad, String weap){
    x = _x;
    y = _y;
    boxNumber = num;
    
    if (weap == "pistol"){
      weapImg = loadImage("images/pistol.png");
    }
    if (weap == "smg"){
      weapImg = loadImage("images/mac.png");
    }
    if (weap == "shotgun"){
      weapImg = loadImage("images/shotgun.png");
    }

    radius = rad;
    //initial startup of the hotbar will have the pistol selected (box #1)
    if (boxNumber == 1){
      isSelected = true;
    }
    else{
      isSelected = false;
    }
    
  }
  boolean isEmpty(){
    if (boxNumber == 1){return false;}
    else{return (ammoCount == 0);}
  }
  void display(){
    pushStyle();
    rectMode(CENTER);
    strokeWeight(3);
    //change fill color based on selection status
    if(isSelected == true){
      //if the pistol is selected only show one color
      if (boxNumber == 1){
        fill(#3CFF03);
      }
      //check the ammo value of the other guns
      else{
        //if there is ammo show green color
        if (ammoCount > 0){
          fill(#3CFF03);
        }
        //otherwise show a red color to signify no ammo
        else{
          fill(#FF5050);
        }
      }
      
      
    
    }
    else{
      fill(125);
    }
    
    rect(x,y,radius*2, radius*2, 7);
    image(weapImg, x-radius + 5, y-radius + 5, radius*1.5, radius*1.5);
    //add in number showing ammo count
    textSize(14);
    fill(0);
    if (boxNumber == 1){
      text("Inf.", x-radius+5,y+radius-5); 
    }
    else{
      text(ammoCount, x-radius+5,y+radius-5); 
    }
    
    popStyle();
  }
}

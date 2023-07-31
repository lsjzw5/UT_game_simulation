class WeaponHotbar {
  //position variables
  float x,y;
  float len,h;
  int selectedBox;
  
  //children weaponboxes
  WeaponBox pistolBox;
  WeaponBox SMGBox;
  WeaponBox shotgunBox;
  
  //initializer
  WeaponHotbar(float _x, float _y){
    x = _x;
    y = _y;
    h = 56;
    len = 109;
    selectedBox = 1;
    
    //create two weabon box children
    pistolBox = new WeaponBox(x - 26.5, y, 1, 25, "pistol");
    SMGBox = new WeaponBox(x + 26.5, y, 2, 25, "smg");
    shotgunBox = new WeaponBox(x + 78, y, 3, 25, "shotgun");
  }  
  
  //user pressed a number key
  void keyreleaseEvent(){
    selectedBox = (selectedBox % 3) + 1;
    changeSelection(selectedBox);
  }
  
  void display(){
    pistolBox.display();
    SMGBox.display();
    shotgunBox.display();
    
  }

  void changeSelection(int selectNum){
    if (selectNum == 1){
      pistolBox.isSelected = true;
      SMGBox.isSelected = false;
      shotgunBox.isSelected = false;
    }
    if (selectNum == 2){
      pistolBox.isSelected = false;
      SMGBox.isSelected = true;
      shotgunBox.isSelected = false;
    }
    if (selectNum == 3){
      pistolBox.isSelected = false;
      SMGBox.isSelected = false;
      shotgunBox.isSelected = true;
    }
    //call player function to change weapon fire type!
    player.changeWeapon(selectNum);
  }
  
  
}

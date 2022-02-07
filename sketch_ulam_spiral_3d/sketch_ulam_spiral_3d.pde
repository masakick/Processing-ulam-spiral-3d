import peasy.*;

String dataLines[];

boolean numbers[] = new boolean[10000];

int unitSize = 2; //点どうしの間隔
float dotSize = 1;

PeasyCam cam;

void setup(){
  size(1024,768,P3D);
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  
  background(0);
  noStroke();  
  smooth();
  
  dataLines = loadStrings("pn_to_10000.txt");
  println("データの行数（素数の数） " + dataLines.length);  
  println("1つめは " + dataLines[0]);
  println("2つめは " + dataLines[1]);
  println("3つめは " + dataLines[2]);
  
  //1から10000までの素数判定のための配列
  for(int i=0; i<dataLines.length; i++){
    int prime = int(dataLines[i]);
    numbers[prime] = true; //iが素数ならば numbers[i]はtrue, 素数でなければfalse
  }
  
  
}

void draw(){

  // 描画する座標
  int x = 0;
  int y = 0;
  // 座標をどう動かすかを計算するための変数
  int dx = 1 * unitSize;
  int dy = 0 * unitSize;
  int n = 1;
  
  float boxHeight = 0; //階段の段数

  background(0);
  
  //光高の設定
  ambientLight(128,128,128);
  lightSpecular(204,204,204);
  directionalLight(128,128,128,1,1,0);   
  
  
  // 原点を中心に移動
  //translate(width/2, height/2);
  
  for(int i=1; i<numbers.length; i++){
    
    //物体の色と反射光に色を割り当てる
    
    // 素数ならば
    if(numbers[i]==true){
      fill(0,200,200);
      specular(0,200,200);
      boxHeight -= dotSize;
      
    }
    else{
      fill(0,64,64);
      specular(0,64,64);
    }
    shininess(1);
    
    pushMatrix();    
    //boxを描く位置に原点を移動
    translate(x, boxHeight, y);
    box(dotSize);
    popMatrix();
    
    //iに応じて次の描画場所を決める */
    if ( n * n + 1 == i ) {
      dy = (n % 2)*2-1;
      dx = 0;
      n++;
    } else if ( n * n - n + 1 == i) {
      dx = (n % 2)*2-1;
      dy = 0;
    }
    x += dx*unitSize;
    y += dy*unitSize;
    
    
    
  }
  
  
}


//一部参考にさせていただきました。
//http://tony-mooori.blogspot.jp/2015/10/processing_25.html

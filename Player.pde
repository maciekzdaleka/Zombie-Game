class Player extends GameObjects
{

  float gravity = .5;
  float jumpSpeed = 11;
  float up;
  float buletCounter;
  boolean alive = true;
  float hand;
  float leg;

  Player(float x ,float y)
  {
    position.x = x;// position of the player
    position.y = y;
    theta = 0;
   }

  void display()
  {  
    if(position.y < 340)// jumping of the player when up is not 0 we can applay jump speed and gravity to put the player down
    {                  //  then we set up as 0 so the player will go down on the ground
        velocity.y += gravity;
        position.add(velocity);
        up = 0;
    }
    else
    {
        velocity.y = 0;
    }
    if(position.y >= 340 && up != 0)
    {
        velocity.y = -jumpSpeed;
        position.add(velocity);
        up = 0;
    }
     pushMatrix();
     translate(position.x,position.y);
     noStroke();
     fill(252,130,244); //eyball color
     rect(hx,hy,30,20); //face
     fill(255,255,0);
     triangle(hx, hy, hx+5, hy- 10, hx+10, hy);
     triangle(hx+10, hy, hx+15, hy- 10, hx+20, hy);
     triangle(hx+20, hy, hx+25, hy- 10, hx+30, hy);
     stroke(255);
     line(hx+15,hy+20,hx+15,(hy+20)+35);
     line(hx+15,hy+55,hx,hy+80); 
     line(hx,hy+80,hx+leg,hy+80);//left leg
     line(hx+15,hy+55,hx+30,hy+80); //right leg
     line(hx+30,hy+80,hx+30+leg,hy+80);
     line(hx+15,hy+40,hx+hand,hy+30);
     fill(0,0,255);
     ellipse(hx+7,hy+6,5,5);
     ellipse(hx+24,hy+6,5,5);
     triangle(hx+10, hy+15, hx+15, hy+10, hx+20, hy+15);
     rotate(theta);// theta is here to only rotate the positon.x not the whole sketch. I've used this for shooting direction
     popMatrix();
   }

    void move()
    {
        if(position.x < 0 )//keeps the player in the box
        {
          position.x = 1;
        }
        if(position.x > 730)
        {
          position.x =729;
        }
        
      forward.x = 5;
      if(keyPressed)
      {
        switch(key)
        {
          case 'd':
          position.add(forward);//players go right
         leg = 10;// leg animation
         theta  =  179.07;// chaning the ditection of x
         hand = 30;
            break;
          case 'a':
          position.sub(forward);
          leg = -10;
          theta = 0;
          hand = 0;
            break;
          case 'w':
          jump.play();//jumps sounds
          jump.rewind();
          up = 1;
            break;
            case ' ':
            if(alive == true)// creating a bullet
            { 
              Bullet bullet = new Bullet();
              bullet.position = position.get(); //we getting the player position and set the bullet posiotion the same   
              bullet.theta = theta;
              objects.add(bullet);
              bullets.add(bullet);
              alive =false;
              buletCounter = 0;
              shoot.play();
              shoot.rewind();
             }
           if(alive == false)//fire rate
            {
              buletCounter ++;
              if(buletCounter == 10 )
              {
                alive = true;
              }
            }
            break;
        }
      }
    }
}

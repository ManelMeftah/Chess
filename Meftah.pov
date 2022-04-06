#include "shapes.inc"
#include "colors.inc"
#include "textures.inc"
#include "woods.inc"
#include "glass.inc"
#include "metals.inc"
#include "functions.inc" 
#include "stones1.inc"
#include "skies.inc"

#declare Pi = 3.1415926535897932384626;    
#declare axe=1;
#declare sca=2;
camera {
location <-.5*sca,1.5*sca,sca>
look_at <0,0,0>
sky   <0,0,1>
right <-image_width/image_height,0,0>
}light_source { <0,0, 3> color rgb<1.5,1,0> }  


background {White}

sky_sphere{ S_Cloud5 rotate<90,0.051,1> }   

//le clock utilisé pour la courbe de bézier: entre 0 et 1
#declare Nr = clock ;

     
#declare Force = 1.00;
#declare Radius  = 1.00;      
    
 
 
 //-----------------------------PION-------------------------------------------------------------------------------------------------------


 #macro Pion(trans, isCoul, coul) 
 
 //Courbe 1:
  #local P0=<.6 , 3.35>;
  #local P1=<.23, .56>;
  #local P2=<2.3, 1>;
  #local P3=<1.7, .56>;
 
 //Courbe 2:  
  #local M0=P3;
  #local k=1/3;
  #local M1=P3+(P3-P2);
  #local M2 = <2.3, 0>;   
  #local M3 = <2.46, -.75>;
 
 //Courbe 3:  
  #local N0 = M3;
  #local N1 = M3+ k*(M3 - M2);
  #local N2 = <2.5, -1.76>;
  #local N3 = <.53, -1.58>;
 
  union{ 
        //deux spheres du dessus:
        union{
          sphere{<0,0,0>, .75 translate<0,0,2.3>}
          sphere{<0,0,0>, .75 scale<1,1, .15> translate<0,0, 1.52> }
         } 
     
         //deux premiers lathes:
         union{
              lathe{
               bezier_spline 4
               P0, P1, P2, P3
               scale .5
               rotate<90, 0, 0>
              }                
              
              //sphere{<0,0,0>, 1  scale<1,1, .2>} 
              
              lathe{
               bezier_spline 4
               M0, M1, M2, M3
               scale .5
               rotate<90, 0, 0>
               //pigment {color Red}
               } 
          }
          //second lathe et la sphere qui constituent la base du pion:
          union{       
              lathe{
               bezier_spline 4
               N0, N1, N2, N3
               scale .5
               rotate<90, 0, 0>
              } 
              
             sphere{<0,0,0>, 1.2 scale<0,0,.1> translate <0,0, -.7>  }   
           }

       #if(isCoul)
            texture{ pigment{color coul}} 
        #else
            texture{ coul}
        #end
        scale .1
        translate trans
   }    
    
  #end //fin macro Pion
  
  
  
//-----------------------------FOU-------------------------------------------------------------------------------------------------------    
    #macro Fou(trans, isCoul, coul) 
    blob{   
                 threshold .65 
                 
                 //les elements du blob apparraissent du plus haut au plus bas :
                 sphere{ <0,0,0>, Radius/2, Force scale<1,.5,1> translate<0,4.2,0>}   //sphere la plus haute
                 
                 sphere{<0,1,0>, Radius, Force scale<2,2.75,2>}
                 sphere{  < 0,1.45,0>,Radius/2,-Force scale<.2,2.75,2> rotate<0,0,-10>}     
                  
                 sphere{<0,0,0>, Radius*2, Force scale <1,.2,1> translate<0,1.2,0>}
                 
                 cylinder{<0,-1.0,0>,<0,2.20,0>, Radius*2, Force translate<0,-2.4,0>} 
                 sphere{<0,0,0>, Radius*3, -Force translate<0, -3, 0>}    
             
                 sphere{<0,0,0>, Radius*2, Force translate<0, -1.5,0> scale 1.5}   
                 sphere{<0,0,0>, Radius*2, Force scale <1,.2,1> translate<0,-4,0>}  //sphere qui constitue la base du Fou
    
    
                 #if(isCoul)
                    texture{ pigment{color coul}} 
                 #else
                     texture{ coul}
                 #end
                 rotate<90,0,70>  
                 scale .07
                 translate trans                     
                       
       }//fin blob
    #end //fin macro Fou
    
    
 //-----------------------------TOUR-------------------------------------------------------------------------------------------------------
    #macro Tour(trans, isCoul, coul) 
    difference{
        union{
           cone{<0,0,0>, 1.3, <0,0,1.5>, 1.5 }  
           sphere{<0,0,0>, 1.5 scale<1,1,.1>} 
           cone{<0,0,-.75>, .75, <0,0,0>, 1.3 }
           cone{<0,0,-.75>, .75, <0,0, -4>, 1.3}
           sphere{<0,0,0>, 1.5 scale<1,1,.1> translate<0,0, -4>} 
           sphere{<0,0,0>, 1.5 scale<1,1,.5> translate<0,0, -4.3>}   
           sphere{<0,0,0>, 1.7 scale<1,1,.1> translate<0,0, -4.9>}
        } //fin Union
        
        //Les cubes au dessus du cone :
        #declare Cube = box{<0,0,0>, <1,1,1> scale .5 translate<-1.5,-.3,1.1>}
        #local n=6;
        #for(i,0,n)
            object{Cube rotate<0,0,360*i/n>}
        #end
       
                 #if(isCoul)
                    texture{ pigment{color coul}} 
                 #else
                     texture{ coul}
                 #end           
                          
        rotate<0,0,10>  
         scale .06
         translate trans
        
     } //fin Diff
     #end //fin macro Tour  
     
     
 //------------------------------ROI-------------------------------------------------------------------------------------------------------   
  #declare Radius  = .9;  

  #macro Roi(trans, isCoul, coul) 
  union{
     //couronne:  
     union{
        sphere{ <0,0,0>, Radius/4 scale 1.5 translate<0,0,-.1>}
        cylinder{<0,0,0>,<0,0,.4>, Radius/5 translate<0,0,-.6>} 
        cone{<0,0,0>, Radius/3, <0,0,.1>, Radius/5 translate<0,0,-.6> }
        cone{<0,0,-1.3>, Radius/2, <0,0,0>, Radius translate<0,0,-.6> }  
     } 
     
     //milieu:
     union{
         torus{Radius/2, .07 rotate<90,0,0> translate<0,0,-1.9>} 
         cone{<0,0,-1.8>, Radius, <0,0,-1.3>, Radius/2 translate<0,0,-.6>} 
     } 
     
     //base:
     union{                                              
         cone{<0,0,0>, .75, <0,0, -4.4>, 1.2 translate<0,0,-.5>}
         sphere{<0,0,0>, 1.3 scale<1,1,.1> translate<0,0, -4.9>} 
         cone{<0,0,0>, 1.2, <0,0,-.4>, 1.4 translate<0,0, -4.9>}   
         sphere{<0,0,0>, 1.6 scale<1,1,.1> translate<0,0, -5.4>}  
     scale .8 
     translate<0,0,-2>
     }
   
     #if(isCoul)
         texture{ pigment{color coul}} 
     #else
         texture{ coul}
     #end
     scale .1   
  
     translate trans
     
  }//fin Union
  #end //fin macro Roi
  
  
 //------------------------------REINE-------------------------------------------------------------------------------------------------------   
 
 #declare Radius  = .9;
 #macro Reine(trans, isCoul, coul)
  union{  
     //couronne:
     difference{  
         union{
                sphere{ <0,0,0>, Radius/4 scale 1.3 translate<0,0,.25>} 
                 //intersection pour etre sure que la sphere ne depasse pas le cone :
                 intersection{
                     sphere{<0,0,0>, Radius scale<1,1,1.7> translate<0,0,-1.5>} 
                     plane{-z .6}
                 } //fin Inter 
                 cone{<0,0,-1.3>, Radius/2, <0,0,0>, Radius translate<0,0,-.6> } 
                 torus{.8, .23 rotate<90,0,0> translate<0,0,-.6>}     
             } //fin Union
                     
         //Les spheres au dessus du cone :
        #declare Sphere = sphere{<0,0,0> Radius/4 scale <1,1,1.5> rotate<-30,0,0> translate<-.95,-.3,-.4>}
        #local n=9;
        #for(i,0,n)
            object{Sphere rotate<0,0,360*i/n>}
        #end
      }//fin difference  
     
     //milieu:
     union{
         torus{Radius/2, .07 rotate<90,0,0> translate<0,0,-1.9>} 
         cone{<0,0,-1.8>, Radius, <0,0,-1.3>, Radius/2 translate<0,0,-.6>} 
     }
     
     //base:
     union{                                              
         cone{<0,0,0>, .75, <0,0, -4.4>, 1.2 translate<0,0,-.5>}
         sphere{<0,0,0>, 1.3 scale<1,1,.1> translate<0,0, -4.9>} 
         cone{<0,0,0>, 1.2, <0,0,-.4>, 1.4 translate<0,0, -4.9>}   
         sphere{<0,0,0>, 1.6 scale<1,1,.1> translate<0,0, -5.4>}  
         
         scale .8 
         translate<0,0,-2>
     } //fin Union
             #if(isCoul)
                texture{ pigment{color coul}} 
             #else
                 texture{ coul}
             #end
     scale .1 
     translate trans
  } //fin Union
#end //fin macro Reine

 
//------------------------------CAVALIER-------------------------------------------------------------------------------------------------------   

 #macro Cavalier(trans, rot, isCoul, coul)
   //Tete du cavalier:
    union{
        #local A = <-1.77, -.3, 2.66>;
        #local B = < 1.72, .3, -.36>;
         
        #local C = <.78, .85>;
        #local D =<.77, -.38> ;
        #local E = <.65, -.37>;  
        
        #local F = <.77, -.4, .83>;
        #local G = < 1.73, .4, -.37>; 
        
        #local S2 = <1.74, .82>;
        #local C2 =<1.2, 0.83> ;
        #local D2 = <1.75, 1.2>;  
        
        #local I2 = <.34, 1.14>; 
        
        #local U = <0.2, 3.2>; 
        #local V = <0.2, 2.66>;  
        #local W = <-.6, 2.66>;          
        
        difference{
            prism{-.3, .3 4 U, V, W, U} 
            prism{0.00, 1.00, 4 <-1.00, 0.00>, < 1.00, 0.00>, < 0.00, 2.00>, <-1.00, 0.00> 
                   scale <.3,0,.3>  
                   rotate<0,180,90>
                   translate <.3,0,3.3>  
                   }
        }  //fin Diff   
        
       difference{ 
            intersection{
                difference{
                        box { A, B } 
                        union{
                          torus{.12, .05 translate<.3,-.3,1.9> pigment{color Black}} 
                          torus{.12, .05 translate<.3,.3,1.9> pigment{color Black}}

                        } //fin Union  
                  }//fin Diff
                  intersection{ 
                      plane{ <1, 0, .53>, 1.6  translate<0,0,.7>}
                      plane{ <-.77, 0, .39>, 1.5 translate<0,0,.5> }
                      plane{ <-.67, 0, -.44>, .8 translate<0,0,.5>}
                  } //fin Inter 
               } //fin Inter
               union{   
                  box{ F, G  } 
                  prism{-.37, .78, 4 C, D, E, C} 
                  prism{S2.y, D.y, 4 S2, D2, C2, S2} 
                  prism{F.y, I2.y, 4 I2, C2, <F.x, F.z>, I2} 
                  
               } //fin Union 
               
        }// fin diff
          
      //Base du cavalier
        union{
            union{
             torus{.9/2, .07 rotate<90,0,0> translate<0,0,0>}
             cone{<0,0,-1.8>, .7, <0,0,-1.3>, .9/2 translate<0,0,1.3>}  
             scale 1.5    
             translate<0,0,-.3>
            }  //fin Union
             union{ 
                                                             
                 cone{<0,0,0>, .75, <0,0, -4.4>, 1.2 translate<0,0,-.5>}
                 sphere{<0,0,0>, 1.3 scale<1,1,.1> translate<0,0, -4.9>} 
                 cone{<0,0,0>, 1.2, <0,0,-.4>, 1.4 translate<0,0, -4.9>}   
                 sphere{<0,0,0>, 1.6 scale<1,1,.1> translate<0,0, -5.4>} 
                 scale <.8, .8, .7> 
              } //fin Union
             translate<.03, 0, .2>
          }//fin Union 

             #if(isCoul)
                texture{ pigment{color coul}} 
             #else
                 texture{ coul}
             #end      
             
             rotate rot        
              scale .08
              translate trans
  }  //fin Union
  #end  //fin macro Cavalier    
  
  
  
 //----------------MACRO DE POSITIONNEMENT DES PIONS:-------------------------------------------------------------------------------------------------------------------
 
 
 #macro posPions(pos)
 //pions noirs:
    #local i=pos;    
    #for (j, 0, 6) 
      Pion(<i-.9,-i-.9,.05>, false, DMFWood5)  
      #local i=i+.35;
      #if (i=-.19) 
           #local i=i+.35;  //le pion qui sera deplace est cree separement
      #end
    #end  
    
    
    //pions blancs:
    #local i=pos;    
    #for (j, 0, 6) 
      Pion(<i+.9,-i+.9,.05>, true, rgb<1,0.7,0.85>)  
      #local i=i+.35;
      #if (i=-0.19-.7)
           #local i=i+.35;  //le pion qui sera deplace est cree separement
      #end
    #end    
 #end  //fin macro PosPions



 //----------------MACROS D'ANIMATIONS:--------------------------------------------------------------------------------------------------------------------
     //Courbe de bezier quadratique:
   #macro paraBez(t1,P0,P1,P2,M)
      #local M=pow(1-t1,2)*P0+2*t1*(1-t1)*P1+pow(t1,2)*P2; 
        // M = P0*(1-t1)^2 + P1*(1-t1) + P2*t1^2
   #end 
 
  #macro AnimBezier(pos1, pos2, debut, fin, isCoul, coul)
        #local P0 = pos1;
        #local Q2 = pos2;
        #local Q1 = <(P0.x+Q2.x)/2,(P0.y+Q2.y)/2, 1>;
        #local i=0;
            
        #local M=<0,0,0>;
        paraBez(My_Clock/20,P0,Q1,Q2,M)  //Calcule la valeur d point M qui se déplace sur la courbe de bezier 
       
      #if(Nr>=debut & Nr < fin) 
           Pion(M,isCoul,coul)  
      #end 
  #end  //fin macro AnimBezier
 

 //----------------PLATEAU DE JEU:--------------------------------------------------------------------------------------------------------------------
#declare Plateau = union{
    box{
        <-1, -.05, -1>, <1, 0, 1> 

        texture{  checker texture{pigment{Brown}}, texture{pigment{White} }
                scale 0.25
               } 
   
    
        scale<2,2,2>
        rotate<90,0,-45>    
    } 
    
    
    union{
         posPions(-1.24)
        
         Fou(<1.8,.7,.28>, true, rgb<1,0.7,0.85> )
         Fou(<.7,1.8,.28>, true, rgb<1,0.7,0.85> )         
         Fou(<-1.8,-.7,.28>, false, DMFWood5 )         
         Fou(<-.7,-1.8,.28>, false, DMFWood5 ) 
         
         
         Tour(<2.5,0, .29>, true, rgb<1,0.7,0.85>)  
         Tour(<0,2.5, .29>, true, rgb<1,0.7,0.85>)    
         Tour(<-2.5,0, .29>, false, DMFWood5)  
         Tour(<0,-2.5, .29>, false, DMFWood5)  
        
         Reine(<1.45,1.05,.63>, true, rgb<1,0.7,0.85> )
         Reine(<-1.05,-1.45,.63>, false, DMFWood5 ) 
         
         Roi(<1.1,1.4,.63>, true, rgb<1,0.7,0.85> )
         Roi(<-1.4,-1.1,.63>, false, DMFWood5 )
         
         Cavalier(<2.15, .35, .3>, <0, 0, 180>, true, rgb<1,0.7,0.85>) 
         Cavalier(<-2.15, -.35, .3>,<0, 0, 0>,false, DMFWood5)
         Cavalier(<-.35, -2.15, .3>,<0, 0, 90>,false, DMFWood5)
          
    } 
    
 //____________________ANIMATION DES PIECES :______________________________________________________________________________________

    #declare Start   =0;
    #declare End=100;
    #declare My_Clock = Start+(End-Start)*clock;
    #if(My_Clock <20)
         AnimBezier(<-0.19+0.9-.7, 0.19+0.9 +.7, .05>, <-0.7-0.19+0.9-.7, -.7+0.19+0.9+.7, .05>, 0, 10/30, true, rgb<1,0.7,0.85>)   
    #else
         Pion(<-0.7-0.19+0.9-.7, -.7+0.19+0.9+.7, .05>,true, rgb<1,0.7,0.85>)        
    #end    
    
    #declare pasVertical=0; 
    #declare pasHorizontal=0; 
    #declare pasCavalier1 =0;
    #declare pasCavalier2=0;
      
    #if(My_Clock=0)    
        #fopen f1"montee.txt"append//write  
        #fopen Data1 "montee.txt" write
        #write(Data1, .05)
        #fclose Data1
        
        #fopen f2"pas.txt"append//write 
        #fopen Data2 "pas.txt" write
        #write(Data2, 0)
        #fclose Data2
        
        #fopen f3"cavalier.txt"append//write 
         #fopen Data3 "cavalier.txt" write
         #write(Data3, 0)
         #fclose Data3 
        
        #fopen f4 "cavalier2.txt" append 
         #fopen Data4 "cavalier2.txt" write
         #write(Data4, 0)
         #fclose Data4 
    #end    
    
    #if(My_Clock>20)
        #fopen Data1 "montee.txt" read
        #read(Data1,pasVertical)
        #fclose Data1 
        #if(My_Clock>20 & My_Clock<29)
            #fopen Data1 "montee.txt" write 
            #write(Data1, pasVertical + .05)
            #fclose Data1 
        #elseif(My_Clock >55 & My_Clock <63)
            #fopen Data1 "montee.txt" write
            #write(Data1, pasVertical - .05)
            #fclose Data1   
        #end
    #end 
    
     #if(My_Clock>30)

        #fopen Data2 "pas.txt" read
        #read(Data2, pasHorizontal)
        #fclose Data2  
        #if(My_Clock>30 & My_Clock<55)
            #fopen Data2 "pas.txt" write
            #write(Data2, pasHorizontal+ .05)
            #fclose Data2
        #end 
      #end 
      
      #if(My_Clock>63)
         #fopen Data3 "cavalier.txt" read
         #read(Data3, pasCavalier1)
         #fclose Data3  
         #if(My_Clock>64 & My_Clock<89)
            #fopen Data3 "cavalier.txt" write
            #write(Data3, pasCavalier1 + .05)
            #fclose Data3
         #end 
       #end  
       
       
       #if(My_Clock>89)
         #fopen Data4 "cavalier2.txt" read
         #read(Data4, pasCavalier2)
         #fclose Data4  
         #if(My_Clock>90 & My_Clock<=100)
            #fopen Data4 "cavalier2.txt" write
            #write(Data4, pasCavalier2 + .09)
            #fclose Data4
         #end 
       #end
    
    #if(My_Clock <=21)
         Pion(<-0.19-0.9,+0.19-0.9, .05>, false, DMFWood5)
          
    #elseif(My_Clock>21 & My_Clock <30) 
         Pion(<-0.19-0.9,+0.19-0.9, pasVertical>,   false, DMFWood5)
         
    #else
         Pion(<-0.19-0.9+pasHorizontal,+0.19-0.9+pasHorizontal, pasVertical>,   false, DMFWood5)
    #end
    
    
    #if(My_Clock<=63)
       Cavalier(<.35, 2.15, .3>,<0, 0, 270>, true,rgb<1,0.7,0.85>)
       
    #elseif(My_Clock >63 & My_Clock<89)
       Cavalier(<.35-pasCavalier1, 2.15-pasCavalier1, .3>,<0, 0, 270>, true,rgb<1,0.7,0.85>)  
       
    #elseif(My_Clock >=89 & My_Clock<=100) 
       Cavalier(<.35+pasCavalier2-pasCavalier1, 2.15-pasCavalier2-pasCavalier1, .3>,<0, 0, 270>, true,rgb<1,0.7,0.85>)   
    #end
   
   
    scale .8  
    
 }    
 
 

 
 
 Plateau
 
          